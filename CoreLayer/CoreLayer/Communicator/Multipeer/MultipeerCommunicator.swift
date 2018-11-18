//
//  MultipeerCommunicator.swift
//  FintechLarin
//
//  Created by Иван Lardis on 28/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation 
import MultipeerConnectivity

public class MultipeerCommunicator: NSObject, ICommunicator {
    private let serviceType = "tinkoff-chat"
    private let discoveryInfo: [String: String]

    weak public var delegate: CommunicatorDelegate?
    private let serviceAdvertiser: MCNearbyServiceAdvertiser
    private let serviceBrowser: MCNearbyServiceBrowser
    private let peerId: MCPeerID
    public var online: Bool

    var sessions: [String: MCSession] = [String: MCSession]()

    override init() {
        self.peerId = MCPeerID(displayName: UIDevice.current.identifierForVendor!.uuidString)
        self.discoveryInfo = ["userName": UIDevice.current.name]
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerId,
                discoveryInfo: discoveryInfo,
                serviceType: serviceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: peerId, serviceType: serviceType)
        self.online = true

        super.init()
        self.serviceBrowser.delegate = self
        self.serviceAdvertiser.delegate = self

        self.serviceAdvertiser.startAdvertisingPeer()
        self.serviceBrowser.startBrowsingForPeers()
    }

    public func sendMessage(string: String, to userID: String, completionHandler: ((Bool, Error?) -> Void)?) {
        do {
            if let session = self.sessions[userID] {
                let messageData = try JSONSerialization.data(withJSONObject: createMessage(text: string))
                try session.send(messageData, toPeers: session.connectedPeers, with: .reliable)
                completionHandler?(true, nil)
            }
        } catch {
            completionHandler?(false, error)
        }
    }

    func createMessage(text: String) -> [String: String] {
        return ["eventType": "TextMessage",
                "messageId": MultipeerCommunicator.generateMessageId(),
                "text": text]
    }

    static func generateMessageId() -> String {
        let string = "\(arc4random_uniform(UINT32_MAX))" +
        "\(Date.timeIntervalSinceReferenceDate)" +
        "\(arc4random_uniform(UINT32_MAX))".data(using: .utf8)!.base64EncodedString()
        return string
    }

    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
}

extension MultipeerCommunicator: MCNearbyServiceAdvertiserDelegate {
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        delegate?.failedToStartAdvertising(error: error)
    }

    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser,
                    didReceiveInvitationFromPeer peerID: MCPeerID,
                    withContext context: Data?,
                    invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        if self.sessions[peerID.displayName] == nil {
            invitationHandler(false, nil)

        } else {
            let session = MCSession(peer: self.peerId, securityIdentity: nil, encryptionPreference: .none)
            session.delegate = self
            self.sessions[peerID.displayName] = session
            invitationHandler(true, session)
        }
    }
}

extension MultipeerCommunicator: MCNearbyServiceBrowserDelegate {
    public func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        delegate?.didLostUser(userID: peerID.displayName)
    }

   public func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        delegate?.failedToStartBrowsingForUsers(error: error)
    }

    public func browser(_ browser: MCNearbyServiceBrowser,
                 foundPeer peerID: MCPeerID,
                 withDiscoveryInfo info: [String: String]?) {
        guard self.peerId.displayName != peerID.displayName,
              let userInfo = info,
              let userName = userInfo["userName"]
                else {
            return
        }

        var session = self.sessions[peerID.displayName]

        if session == nil {
            session = MCSession(peer: self.peerId, securityIdentity: nil, encryptionPreference: .none)
            session!.delegate = self
            self.sessions[peerID.displayName] = session
        }

        browser.invitePeer(peerID, to: session!, withContext: nil, timeout: 30)
        self.delegate?.didFoundUser(userID: peerID.displayName, userName: userName)
    }
}

extension MultipeerCommunicator: MCSessionDelegate {
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    }

public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        do {
            if let jsonObjectData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               jsonObjectData["eventType"] as? String == "TextMessage",
               let text = jsonObjectData["text"] as? String,
               let messageId = jsonObjectData["messageId"] as? String {
                delegate?.didReceiveMessage(text: text,
                        messageId: messageId,
                        fromUser: peerID.displayName,
                        toUser: self.peerId.displayName)
            }
        } catch {
            print("Unable to receive data")
        }
    }

public func session(_ session: MCSession,
                 didReceive stream: InputStream,
                 withName streamName: String,
                 fromPeer peerID: MCPeerID) {
    }

public func session(_ session: MCSession,
                 didStartReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID,
                 with progress: Progress) {
    }

public func session(_ session: MCSession,
                 didFinishReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID,
                 at localURL: URL?,
                 withError error: Error?) {
    }
}

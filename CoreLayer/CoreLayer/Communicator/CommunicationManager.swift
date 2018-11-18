//
//  CommunicationManager.swift
//  FintechLarin
//
//  Created by Иван Lardis on 28/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class CommunicationManager: NSObject, CommunicatorDelegate, ICommunicationManager {
    var data: [String: ConversationModel] = [String: ConversationModel]()
    var communicator: ICommunicator

    public weak var communicationDelegate: ICommunicationDelegate?

    public init(communicator: ICommunicator) {

        self.communicator = communicator
        super.init()
        self.communicator.delegate = self
    }

    func didFoundUser(userID: String, userName: String?) {

        print("didFoundUser")
        if let model = data[userID] {
            model.online = true
        } else {
            data[userID] = ConversationModel.init(name: userName ?? " Anon",
                    date: Date(),
                    online: true,
                    hasUnreadMessages: false,
                    conversationId: userID)
        }

        updateData()
    }

    func sendMessage(text: String, toUserID: String) {

        print("toUserID \(toUserID)")
        if let model = data[toUserID] {

            model.message.append(MessageModel.init(textMessage: text,
                    isIncomingMessage: false,
                    date: Date(),
                    messageId: MultipeerCommunicator.generateMessageId()))
        }
        communicator.sendMessage(string: text, to: toUserID, completionHandler: nil)

        updateData()
    }

    func updateData() {
        communicationDelegate?.updateData(data: self.data)
    }

    func didLostUser(userID: String) {

        if let model = data[userID] {
            model.online = false
        }

        updateData()
    }

    func failedToStartBrowsingForUsers(error: Error) {
    }

    func failedToStartAdvertising(error: Error) {
    }

    func didReceiveMessage(text: String, messageId: String, fromUser: String, toUser: String) {
        if let model = data[fromUser] {
            model.message.append(MessageModel.init(textMessage: text,
                    isIncomingMessage: true,
                    date: Date(),
                    messageId: messageId))
        }

        updateData()
    }
}

//
//  CommunicationManager.swift
//  FintechLarin
//
//  Created by Иван Lardis on 28/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class CommunicationManager: NSObject, CommunicatorDelegate {
    var data: [String: ConversationModel] = [String: ConversationModel]()
    var communicator: Communicator

    weak var communicationManagerDelegate: CommunicationManagerDelegate?

    override init() {
        let userName: String = ProfileDataManager.init().getUserName()
        communicator = MultipeerCommunicator.init(userName: userName)
        super.init()
        communicator.delegate = self
    }

    func didFoundUser(userID: String, userName: String?) {
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
        communicationManagerDelegate?.updateData(data: self.data)
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

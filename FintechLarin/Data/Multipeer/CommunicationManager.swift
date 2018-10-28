//
//  CommunicationManager.swift
//  FintechLarin
//
//  Created by Иван Lardis on 28/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class CommunicationManager: NSObject, CommunicatorDelegate {
    var data: [String: ConversationsCellModel] = [String: ConversationsCellModel]()
    var communicator: Communicator
    weak var conversationDelegate: IConversationView?
    weak var conversationListDelegate: IConversationListView?
    var toUserID: String?

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
            data[userID] = ConversationsCellModel.init(name: userName ?? " Anon",
                    date: Date(),
                    online: true,
                    hasUnreadMessages: false,
                    toUserID: userID)
        }

        updateData()
    }

    func sendMessage(text: String, toUserID: String) {
        if let model = data[toUserID] {

            model.message.append(ConversationCellModel.init(textMessage: text, isIncomingMessage: false, date: Date()))
        }
        communicator.sendMessage(string: text, to: toUserID, completionHandler: nil)

        updateData()
    }

    func updateData() {
        DispatchQueue.main.async {
            self.conversationListDelegate?.showData(models: self.data.map {
                $1
            })
            if let userName = self.toUserID,
               let conversationModel = self.data[userName] {
                self.conversationDelegate?.showData(models: conversationModel)
            }
        }
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

    func didReceiveMessage(text: String, fromUser: String, toUser: String) {
        if let model = data[fromUser] {
            model.message.append(ConversationCellModel.init(textMessage: text, isIncomingMessage: true, date: Date()))
        }

        updateData()
    }
}

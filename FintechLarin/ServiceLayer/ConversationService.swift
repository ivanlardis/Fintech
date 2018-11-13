//
//  ConversationService.swift
//  FintechLarin
//
//  Created by Иван Lardis on 12/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreData

class ConversationService: NSObject,
        CommunicationManagerDelegate {
    var communicationManager: CommunicationManager?
    var coreDataManager: CoreDataManager?

    weak var conversationDelegate: IMessageListView?
    weak var conversationListDelegate: IConversationListView?

    init(communicationManager: CommunicationManager?,
         coreDataManager: CoreDataManager?) {
        self.communicationManager = communicationManager
        self.coreDataManager = coreDataManager
    }

    func getConversationFRC() -> NSFetchedResultsController<Conversation> {

        return coreDataManager!.getConversationFRC()
    }

    func getMessageFRC(modelId: String) -> NSFetchedResultsController<Message> {

        return coreDataManager!.getMessageFRC(conversationId: modelId)
    }

    func sendMessage(text: String, toUserID: String) {
        communicationManager?.sendMessage(text: text, toUserID: toUserID)
    }

    func updateData(data: [String: ConversationModel]) {
        print("update!!!")
        coreDataManager?.updateConversations(models: data.map {
            $1
        }, callBack: { _ in })

    }

}

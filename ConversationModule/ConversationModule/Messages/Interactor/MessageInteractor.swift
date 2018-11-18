//
//  MessageInteractor.swift
//  ConversationModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import ServiceLayer
import CoreData
import CoreLayer

class MessageInteractor: IMessageInteractor {

    let service: IConversationService

    init(service: IConversationService) {
        self.service = service
    }

    func getMessageFRC(conversationId: String) -> NSFetchedResultsController<Message> {
        print("getMessageFRC")
        return self.service.getMessageFRC(conversationId: conversationId)
    }

    func sendMessage(text: String, toUserID: String) {
        print("sendMessage")
        self.service.sendMessage(text: text, toUserID: toUserID)
    }

}

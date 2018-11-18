//
//  MessageInteractor.swift
//  ConversationModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import ServiceLayer
import CoreLayer
import CoreData

class MessageInteractor: IMessageInteractor {

    let service: IConversationService

    init(service: IConversationService) {
        self.service = service
    }

    public func getMessageFRC(conversationId: String) -> NSFetchedResultsController<Message> {
        return service.getMessageFRC(conversationId: conversationId)
    }

    public func sendMessage(text: String, toUserID: String) {
        service.sendMessage(text: text, toUserID: toUserID)
    }
}

//
//  ConversationService.swift
//  FintechLarin
//
//  Created by Иван Lardis on 12/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreData
import CoreLayer

public class ConversationService: IConversationService,
ICommunicationDelegate {
    var communication: ICommunicationManager
    var storage: IStorage
    
    public init(communication: ICommunicationManager,
                storage: IStorage) {
        self.communication = communication
        self.storage = storage
    }
    
    public func getConversationFRC() -> NSFetchedResultsController<Conversation> {
        return storage.getConversationFRC()
    }
    
    public func getMessageFRC(conversationId: String) -> NSFetchedResultsController<Message> {
        return storage.getMessageFRC(conversationId: conversationId)
    }
    
    public func sendMessage(text: String, toUserID: String) {
        communication.sendMessage(text: text, toUserID: toUserID)
    }
    
    public func updateData(data: [String: ConversationModel]) {
        storage.updateConversations(models: data.map {
            $1
        })
    }
}

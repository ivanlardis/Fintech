//
//  IConversationService.swift
//  ServiceLayer
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreData
import CoreLayer

public protocol IConversationService: class {
    func getConversationFRC() -> NSFetchedResultsController<Conversation>
    func getMessageFRC(conversationId: String) -> NSFetchedResultsController<Message>
    func sendMessage(text: String, toUserID: String)
}

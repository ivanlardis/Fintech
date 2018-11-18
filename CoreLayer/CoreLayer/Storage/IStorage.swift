//
//  IStorage.swift
//  CoreLayer
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreData

public protocol IStorage: class {
    func saveProfile(model: ProfileModel) -> Bool
    func loadProfile() -> ProfileModel?
    func updateConversations(models: [ConversationModel])
    func getConversationFRC() -> NSFetchedResultsController<Conversation>
    func getMessageFRC(conversationId: String) -> NSFetchedResultsController<Message>
}

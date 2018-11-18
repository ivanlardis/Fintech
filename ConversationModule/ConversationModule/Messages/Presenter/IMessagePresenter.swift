//
//  IMessagePresenter.swift
//  ConversationModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer
import CoreData

protocol IMessagePresenter: class {
    func getMessageFRC(conversationId: String) -> NSFetchedResultsController<Message>
    func sendMessage(text: String, toUserID: String)

}

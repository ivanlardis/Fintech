//
//  ConversationInteractor.swift
//  ConversationModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import ServiceLayer
import CoreData
import CoreLayer

class ConversationInteractor: IConversationInteractor {
    let service: IConversationService

    init(service: IConversationService) {
        self.service = service
    }

    func getConversationFRC() -> NSFetchedResultsController<Conversation> {
        return service.getConversationFRC()
    }
}

//
//  ConversationDI.swift
//  FintechLarin
//
//  Created by Иван Lardis on 29/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer
import ServiceLayer
class ConversationDI: NSObject {

    private static var communicationManager: CommunicationManager?
    private static var coreDataManager: CoreDataManager?

    private static var conversationService: ConversationService?

    private static func invalidate() {
        if coreDataManager == nil {
            let coreDataStack = CoreDataStack.init()
            coreDataManager = CoreDataManager.init(coreDataStack: coreDataStack)
        }
        if communicationManager == nil {
            communicationManager = CommunicationManager()
        }

        if conversationService == nil {
            conversationService = ConversationService.init(communicationManager: communicationManager,
                    coreDataManager: coreDataManager)

            communicationManager?.communicationManagerDelegate = conversationService
        }
    }

    static func inject(messageListViewController: MessageListViewController) {
        invalidate()
        messageListViewController.conversationService = conversationService
    }

    static func inject(conversationListViewController: ConversationListViewController) {
        invalidate()
        conversationListViewController.conversationService = conversationService
    }

    static func reject(viewController: MessageListViewController) {
        invalidate()
        viewController.conversationService = nil
    }

    static func reject(viewController: ConversationListViewController) {
        invalidate()
        viewController.conversationService = nil
      
    }
}

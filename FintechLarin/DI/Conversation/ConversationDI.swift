//
//  ConversationDI.swift
//  FintechLarin
//
//  Created by Иван Lardis on 29/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ConversationDI: NSObject {

    private static var communicationManager: CommunicationManager?

    private static func invalidate() {
        if communicationManager == nil {
            communicationManager = CommunicationManager.init()
        }
    }

    static func inject(viewController: ConversationViewController) {
        invalidate()
        viewController.communicationManager = communicationManager
        communicationManager?.conversationDelegate = viewController
    }

    static func reject(viewController: ConversationViewController) {
        invalidate()
        viewController.communicationManager = nil
        communicationManager?.conversationDelegate = nil
    }

    static func inject(viewController: ConversationListViewController) {
        invalidate()
        viewController.communicationManager = communicationManager
        communicationManager?.conversationListDelegate = viewController
    }

    static func reject(viewController: ConversationListViewController) {
        invalidate()
        viewController.communicationManager = nil
        communicationManager?.conversationListDelegate = nil
    }
}

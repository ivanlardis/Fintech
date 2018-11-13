//
//  DI.swift
//  FintechLarin
//
//  Created by Иван Lardis on 20/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

class ProfileDI {

    private static var coreDataManager: CoreDataManager?

    private static func invalidate() {
        if coreDataManager == nil {
            let coreDataStack = CoreDataStack.init()
            coreDataManager = CoreDataManager.init(coreDataStack: coreDataStack)
        }
    }

    static func inject(viewController: ProfileViewController) {
        invalidate()
        viewController.coreDataManager = coreDataManager
    }

    static func inject(viewController: MessageListViewController) {
        invalidate()
        viewController.coreDataManager = coreDataManager
    }

    static func inject(viewController: ConversationListViewController) {
        invalidate()
        viewController.coreDataManager = coreDataManager
    }
}

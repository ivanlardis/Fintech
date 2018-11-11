//
//  DI.swift
//  FintechLarin
//
//  Created by Иван Lardis on 20/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

class ProfileDI {

    static func inject(viewController: ProfileViewController) {
//        let profileDataManager = ProfileDataManager.init()
//        viewController.operationDataManager = OperationDataManager.init(profileDataManager: profileDataManager)
//        viewController.gCDDataManager = GCDDataManager.init(profileDataManager: profileDataManager)

        let coreDataStack = CoreDataStack.init()
        viewController.coreDataManager = CoreDataManager.init(coreDataStack: coreDataStack)
    }
}

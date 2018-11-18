//
//  AppRouter.swift
//  Modules
//
//  Created by Иван Lardis on 08.06.18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Router
import ThemeModule
import ProfileModule
import ConversationModule

class AppRouter: IRouter {

    func handle(_ screen: AppScreens,
                action: (UIViewController) -> Void) -> Bool {
        for iRouter in getRouters() {
            if (iRouter.handle(screen, action: action)) {
                return true
            }
        }

        return false
    }

    func getRouters() -> [IRouter] {
        return [
            ThemeRouter.init(),
            ProfileRouter.init(),
            ConversationRouter.init()
        ]
    }
}

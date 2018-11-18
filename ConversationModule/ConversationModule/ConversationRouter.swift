//
//  ConversationRouter.swift
//  ConversationModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import Router

public class ConversationRouter: IRouter {
    public init() {
    }

    public func handle(_ screen: AppScreens,
                       action: (UIViewController) -> Void) -> Bool {

        if (screen == AppScreens.Conversation) {
            let bundle = Bundle(identifier: "ivanlarin.ConversationModule")
            let storyboard = UIStoryboard(name: "Main", bundle: bundle)
            let initialViewController = storyboard.instantiateInitialViewController()
            if let controller = initialViewController {
                action(controller)
                return true
            }
        }

        return false
    }
}

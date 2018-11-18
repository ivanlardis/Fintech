//
//  ThemeRouter.swift
//  ThemeModule
//
//  Created by Иван Lardis on 17/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import Router

public class ThemeRouter: IRouter {
    public init() {
    }

    public func handle(_ screen: AppScreens,
                       action: (UIViewController) -> Void
    ) -> Bool {

        if (screen == AppScreens.Theme) {
            let bundle = Bundle(identifier: "ivanlarin.ThemeModule")
            let storyboard = UIStoryboard(name: "Theme", bundle: bundle)
            if let controller = storyboard.instantiateInitialViewController() {

                action(controller)

                return true
            }
        }

        return false
    }
}

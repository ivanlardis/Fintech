//
//  AppDelegate.swift
//  FintechLarin
//
//  Created by Иван Lardis on 23.09.18.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import Router
import ThemeModule

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        RouterAssembly.initRouter(router: AppRouter())
        ThemeСonfigurator.configurate()
        return startFirstScreen()
    }

    func startFirstScreen() -> Bool {
        return RouterAssembly.getRouter().handle(AppScreens.Conversation) {
            viewController in
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
    }


}

//
//  AppDelegate.swift
//  FintechLarin
//
//  Created by Иван Lardis on 23.09.18.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var lastState = "Not running"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Logger.setDebugMode(isDebug: true)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        showState(functionName: #function)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        showState(functionName: #function)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        showState(functionName: #function)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        showState(functionName: #function)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        showState(functionName: #function)
    }

    func showState(functionName: String) {
        let curState = UIApplication.shared.applicationState.name()
        Logger.d(message: "Application moved from \(lastState) to \(curState): \(functionName).")
        lastState = curState
    }
    
}




//
//  Logger.swift
//  FintechLarin
//
//  Created by Иван Lardis on 23.09.18.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

class Logger {
    private static var isShowLog = false

    static func setDebugMode(isDebug: Bool) {
        isShowLog = isDebug
    }

    static func d(message: String) {
        if (isShowLog) {
            print(message)
        }
    }
}

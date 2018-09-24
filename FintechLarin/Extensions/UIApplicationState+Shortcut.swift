//
//  UIApplicationState+Shortcut.swift
//  FintechLarin
//
//  Created by Иван Lardis on 24.09.18.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

extension UIApplicationState {
    func name() -> String {
        switch self {
        case .active:
            return "active"
        case .background:
            return "background"
        case .inactive:
            return "inactive"
        }
    }
}

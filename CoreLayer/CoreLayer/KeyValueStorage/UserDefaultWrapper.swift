//
//  UserDefaultWrapper.swift
//  CoreLayer
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class UserDefaultWrapper: IKeyValueStorage {

    private let themeColor = "themeColor"

    func saveThemeCollor(color: UIColor) {
        UserDefaults.standard.set(color, forKey: themeColor)
    }

    func getThemeCollor() -> UIColor {
        if let themeColor = UserDefaults.standard.color(forKey: self.themeColor) {
            return themeColor
        } else {

            return UIColor.blue
        }
    }
}

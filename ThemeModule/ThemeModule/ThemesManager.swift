//
//  ThemesManager.swift
//  FintechLarin
//
//  Created by Иван Lardis on 14/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ThemesManager: NSObject {


    func handleTheme(_ controller: ThemesViewController, _ color: UIColor?) {
        if let curColor = color {
            controller.view.backgroundColor = curColor

            DispatchQueue.global(qos: .default).async {
                UserDefaults.standard.set(curColor, forKey: self.themeColor)
            }

            configureTheme(color: curColor)
            reloadColors()
            logThemeChanging(selectedTheme: curColor)
        }
    }

    func configureTheme() {

        DispatchQueue.global(qos: .default).async {
            if let themeColor = UserDefaults.standard.color(forKey: self.themeColor) {
                DispatchQueue.main.async {
                    self.configureTheme(color: themeColor)
                }
            }
        }
    }

     

    func logThemeChanging(selectedTheme: UIColor) {
        print(selectedTheme)
    }

    func reloadColors() {
        
    }
}

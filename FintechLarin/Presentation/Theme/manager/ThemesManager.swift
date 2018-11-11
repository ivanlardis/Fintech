//
//  ThemesManager.swift
//  FintechLarin
//
//  Created by Иван Lardis on 14/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

class ThemesManager: NSObject {

    private let themeColor = "themeColor"

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

    private func configureTheme(color: UIColor) {
        UINavigationBar.appearance().backgroundColor = color
    }

    func logThemeChanging(selectedTheme: UIColor) {
        print(selectedTheme)
    }

    func reloadColors() {
        let windows = UIApplication.shared.windows
        for window in windows {
            for view in window.subviews {
                view.removeFromSuperview()
                window.addSubview(view)
            }
        }
    }
}

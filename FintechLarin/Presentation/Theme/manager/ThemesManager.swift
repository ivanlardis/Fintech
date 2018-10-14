//
//  ThemesManager.swift
//  FintechLarin
//
//  Created by Иван Lardis on 14/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

class ThemesManager: NSObject {

    private let ARG_THEME_COLOR = "arg:themeColor"

    func handleTheme(_ controller: ThemesViewController, _ color: UIColor?) {
        if let _color = color {
            controller.view.backgroundColor = _color

            UserDefaults.standard.set(_color, forKey: ARG_THEME_COLOR)
            configureTheme(color: _color)
            reloadColors()
            logThemeChanging(selectedTheme: _color)
        }
    }

    func configureTheme() {
        if let themeColor = UserDefaults.standard.color(forKey: ARG_THEME_COLOR) {
            configureTheme(color: themeColor)
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

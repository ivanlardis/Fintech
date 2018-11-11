//
//  ThemesManager+Delegate.swift
//  FintechLarin
//
//  Created by Иван Lardis on 14/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

extension ThemesManager: ThemesViewControllerDelegate {
    func themesViewController(_ controller: ThemesViewController, didSelectTheme selectedTheme: UIColor) {
        handleTheme(controller, selectedTheme)
    }
}

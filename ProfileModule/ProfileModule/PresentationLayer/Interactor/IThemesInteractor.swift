//
//  IThemesInteractor.swift
//  ThemeModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

public protocol IThemesInteractor: class {
    func selectedTheme1() -> UIColor
    func selectedTheme2() -> UIColor
    func selectedTheme3() -> UIColor
    func loadTheme() -> UIColor
}

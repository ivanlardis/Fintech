//
//  ThemeСonfigurator.swift
//  ThemeModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

public class ThemeСonfigurator: NSObject {
    public static func configurate() {
        let themes = ThemesStub.init()
        themes.configurate()

    }
}

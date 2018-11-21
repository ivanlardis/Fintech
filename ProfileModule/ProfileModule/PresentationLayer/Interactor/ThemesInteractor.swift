//
//  ThemesInteractor.swift
//  ThemeModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import ServiceLayer

class ThemesInteractor: IThemesInteractor {
    
    private let theme1: UIColor = UIColor.blue
    private let theme2: UIColor = UIColor.green
    private let theme3: UIColor = UIColor.red
    
    let themesService: IThemesService
    
    init(themesService: IThemesService) {
        self.themesService = themesService
    }
    
    func selectedTheme3() -> UIColor {
        self.themesService.saveThemeCollor(color: theme3)
        return theme3
    }
    
    func selectedTheme2() -> UIColor {
        self.themesService.saveThemeCollor(color: theme2)
        return theme2
    }
    
    func selectedTheme1() -> UIColor {
        self.themesService.saveThemeCollor(color: theme1)
        return theme1
    }
    
    func loadTheme() -> UIColor {
        return self.themesService.getThemeCollor()
    }
}


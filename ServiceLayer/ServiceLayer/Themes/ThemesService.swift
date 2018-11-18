//
//  ThemesService.swift
//  ServiceLayer
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer
class ThemesService: IThemesService {
    let keyValueStorage: IKeyValueStorage
    
    init(keyValueStorage: IKeyValueStorage) {
        self.keyValueStorage = keyValueStorage
    }
    
    func saveThemeCollor(color: UIColor) {
        keyValueStorage.saveThemeCollor(color: color)
    }
    
    func getThemeCollor() -> UIColor {
        return  keyValueStorage.getThemeCollor()
    }
}

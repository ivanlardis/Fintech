//
//  IKeyValueStorage.swift
//  CoreLayer
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

public protocol IKeyValueStorage: class {
    func saveThemeCollor(color: UIColor)
    func getThemeCollor() -> UIColor
}  

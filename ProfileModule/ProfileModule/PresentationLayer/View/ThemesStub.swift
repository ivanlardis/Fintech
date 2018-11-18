//
//  ThemesStub.swift
//  ThemeModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ThemesStub: IThemesView {
    public var themesPresenter  : IThemesPresenter?
   
    init() {
        ThemeAssembly().inject(view: self)
    }

    public func configurate() {
        themesPresenter?.loadTheme()
    }
    func configureTheme(color: UIColor) {
        ApperanceUtils.configureTheme(color: color)
    }    
}

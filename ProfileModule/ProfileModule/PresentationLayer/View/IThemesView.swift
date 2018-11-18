//
//  IThemesView.swift
//  ThemeModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

protocol IThemesView: class {
    var themesPresenter  : IThemesPresenter? { get set }
    func configureTheme(color: UIColor)
}

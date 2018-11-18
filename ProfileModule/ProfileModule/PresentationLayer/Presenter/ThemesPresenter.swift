//
//  ThemesPresenter.swift
//  ThemeModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import Router

class ThemesPresenter: IThemesPresenter {
    let themesInteractor: IThemesInteractor
    let router: IRouter
    weak var view: IThemesView?

    init(themesInteractor: IThemesInteractor,
         router: IRouter,
         view: IThemesView) {
        self.themesInteractor = themesInteractor
        self.router = router
        self.view = view
    }

    func selectedTheme1() {
        let color = themesInteractor.selectedTheme1()
        view?.configureTheme(color: color)
    }

    func selectedTheme2() {
        let color = themesInteractor.selectedTheme2()
        view?.configureTheme(color: color)
    }

    func selectedTheme3() {
        let color = themesInteractor.selectedTheme3()
        view?.configureTheme(color: color)
    }

    func loadTheme() {
        let color = themesInteractor.loadTheme()
        view?.configureTheme(color: color)
    }
}

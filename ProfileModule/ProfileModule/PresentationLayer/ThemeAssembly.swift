//
//  ThemeAssembly.swift
//  ThemeModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import ServiceLayer
import Router

class ThemeAssembly: NSObject {
    
    func inject(view: IThemesView) {
        let service: IThemesService = ServiceLayerAssemblyFactory.getServiceLayerAssembly().getThemesService()
        let interactor: IThemesInteractor = ThemesInteractor.init(themesService: service)
        let router: IRouter = RouterAssembly.getRouter()
        
        let presenter: IThemesPresenter = ThemesPresenter.init(themesInteractor: interactor,
                                                               router: router,
                                                               view: view)
        view.themesPresenter = presenter
    }
}

//
//  AssemblyProfile.swift
//  ProfileModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

import UIKit
import ServiceLayer
import Router

class AssemblyProfile: NSObject {
    
    func inject(view: IProfileView) {
        let service: IProfileService = ServiceLayerAssemblyFactory.getServiceLayerAssembly().getProfileService()
        let interactor: IProfileInteractor = ProfileInteractor.init(profileService: service)
        let router: IRouter = RouterAssembly.getRouter()
        let presenter: IProfilePresenter = ProfilePresenter.init(profileInteractor: interactor, router: router, view: view)
        view.profilePresenter = presenter
    }
}

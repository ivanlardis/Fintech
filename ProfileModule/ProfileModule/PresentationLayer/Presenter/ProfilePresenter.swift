//
//  ProfilePresenter.swift
//  ProfileModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer
import Router

class ProfilePresenter: IProfilePresenter {
    private let profileInteractor: IProfileInteractor
    private let router: IRouter
    private weak var view: IProfileView?
    
    init(profileInteractor: IProfileInteractor,
         router: IRouter,
         view: IProfileView) {
        self.profileInteractor = profileInteractor
        self.router = router
        self.view = view
    }
    
    func saveProfile(model: ProfileModel) {
        view?.showLoading(show: true)
        DispatchQueue.global(qos: .default).async {
            let success = self.profileInteractor.saveProfile(model: model)
            
            DispatchQueue.main.async {
                self.view?.showSaveAction(success: success)
                self.view?.showLoading(show: false)
            }
        }
    }
    
    func loadProfile() {
        view?.showLoading(show: true)
        
        DispatchQueue.global(qos: .default).async {
            let profile = self.profileInteractor.loadProfile()
            DispatchQueue.main.async {
                if let model = profile {
                    self.view?.showData(model: model)
                }
                self.view?.showLoading(show: false)
            }
        }
    }
}

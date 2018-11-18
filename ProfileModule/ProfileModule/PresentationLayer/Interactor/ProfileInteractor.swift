//
//  ProfileInteractor.swift
//  ProfileModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import ServiceLayer
import CoreLayer

class ProfileInteractor: IProfileInteractor {
    let profileService: IProfileService

    init(profileService: IProfileService) {
        self.profileService = profileService
    }

    func saveProfile(model: ProfileModel) -> Bool {
        return self.profileService.saveProfile(model: model)
    }

    func loadProfile() -> ProfileModel? {
        return self.profileService.loadProfile()
    }

}

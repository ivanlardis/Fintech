//
//  ProfileService.swift
//  ServiceLayer
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer
class ProfileService: IProfileService {
    let storage: IStorage
    
    init(storage: IStorage) {
        self.storage = storage
    }
    
    func saveProfile(model: ProfileModel) -> Bool {
       return self.storage.saveProfile(model: model)
    }
    
    func loadProfile() -> ProfileModel? {
        return self.storage.loadProfile()
    }
}

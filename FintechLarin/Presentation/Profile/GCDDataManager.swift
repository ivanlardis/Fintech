//
//  GCDDataManager.swift
//  FintechLarin
//
//  Created by Иван Lardis on 20/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

class GCDDataManager: MultithreadingDataManager {

    let profileDataManager: ProfileDataManager

    init(profileDataManager: ProfileDataManager) {
        self.profileDataManager = profileDataManager
    }

    func save(model: ProfileModel, callback: @escaping  (Bool) -> Void) {

        DispatchQueue.global(qos: .default).async {
            let response = self.profileDataManager.save(model: model)

            DispatchQueue.main.async {
                callback(response)
            }
        }
    }

    func loadData(callback: @escaping (ProfileModel) -> Void) {
        DispatchQueue.global(qos: .default).async {
            let model = self.profileDataManager.loadData()
            DispatchQueue.main.async {
                callback(model)
            }
        }
    }

}

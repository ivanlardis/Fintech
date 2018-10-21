//
//  OperationDataManager.swift
//  FintechLarin
//
//  Created by Иван Lardis on 20/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

class OperationDataManager: MultithreadingDataManager {

    let profileDataManager: ProfileDataManager

    init(profileDataManager: ProfileDataManager) {
        self.profileDataManager = profileDataManager
    }

    func save(model: ProfileViewModel, callback: @escaping (Bool) -> Void) {
        let queue = OperationQueue()
        queue.addOperation(SaveOperation.init(model: model, callback: callback, profileDataManager: profileDataManager))
    }

    func loadData(callback: @escaping  (ProfileViewModel) -> Void) {
        let queue = OperationQueue()
        queue.addOperation(LoadOperation.init(profileDataManager: profileDataManager, callback: callback))
    }

    class LoadOperation: Operation {
        let callback: (ProfileViewModel) -> Void
        let profileDataManager: ProfileDataManager

        init(profileDataManager: ProfileDataManager,
             callback: @escaping  (ProfileViewModel) -> Void) {
            self.callback = callback
            self.profileDataManager = profileDataManager
        }

        override func main() {
            let model = profileDataManager.loadData()
            OperationQueue.main.addOperation({
                self.callback(model)
            })
        }
    }

    class SaveOperation: Operation {
        let callback: (Bool) -> Void
        let model: ProfileViewModel
        let profileDataManager: ProfileDataManager

        init(model: ProfileViewModel,
             callback: @escaping  (Bool) -> Void,
             profileDataManager: ProfileDataManager) {
            self.callback = callback
            self.model = model
            self.profileDataManager = profileDataManager
        }

        override func main() {
            let response = profileDataManager.save(model: model)
            OperationQueue.main.addOperation({
                self.callback(response)
            })
        }
    }
}

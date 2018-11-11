//
//  CoreDataManager.swift
//  FintechLarin
//
//  Created by Иван Lardis on 05/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }

    func loadProfile(callBack: @escaping (ProfileViewModel?) -> Void) {
        if let mainContext = self.coreDataStack.mainContext {

            let userCoreData = CoreDataManager.findOrInsertDefaultUser(in: mainContext)

            let profile = ProfileViewModel.init()
            profile.description = userCoreData?.userDescription
            profile.name = userCoreData?.userName
            if let coreDataAvatar = userCoreData?.userAvatar {
                profile.avatar = UIImage.init(data: coreDataAvatar)
            }
            callBack(profile)
        }

        callBack(nil)
    }

    func saveProfile(model: ProfileViewModel, callBack: @escaping (Bool) -> Void) {

        if let saveContext = self.coreDataStack.saveContext {
            saveContext.perform {
                if let userCoreData = CoreDataManager.findOrInsertDefaultUser(in: saveContext) {

                    if let profileName = model.name {
                        userCoreData.userName = profileName
                    }

                    if let profileDescription = model.description {
                        userCoreData.userDescription = profileDescription
                    }

                    if let profileImage = model.avatar {
                        userCoreData.userAvatar = profileImage.jpegData(compressionQuality: 1.0)!
                    }

                    self.coreDataStack.performSave(context: saveContext, completionHandler: {
                        DispatchQueue.main.async {
                            callBack(true)
                        }
                    })
                }
            }
        }
    }

    static func insertDefaultUser(in context: NSManagedObjectContext) -> AppUser? {
        let defaultAppUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser
        defaultAppUser?.userName = "IvanLardis"
        defaultAppUser?.userDescription = "Много текста и т д. Много текста и т д. "
        defaultAppUser?.userAvatar = UIImage(named: "placeholder-user")?.jpegData(compressionQuality: 1)

        return defaultAppUser
    }

    static func findOrInsertDefaultUser(in context: NSManagedObjectContext) -> AppUser? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Model is not available in context!")
            assert(false)
            return nil
        }

        var profile: AppUser?

        guard let fetchRequest = AppUser.fetchRequestAppUser(model: model) else {
            return nil
        }

        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2, "Multiple profiles found!")
            if let foundProfile = results.first {
                profile = foundProfile
            }
        } catch {
            print("Failed to fetch profile: \(error)")
        }

        if profile == nil {
            profile = insertDefaultUser(in: context)
        }
        return profile
    }
}

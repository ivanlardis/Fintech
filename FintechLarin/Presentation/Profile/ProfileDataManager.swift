//
//  ProfileDataManager.swift
//  FintechLarin
//
//  Created by Иван Lardis on 20/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

class ProfileDataManager {

    private let ARG_PROFILE_NAME = "arg:profileName"
    private let ARG_PROFILE_DESCRIPTION = "arg:profileDescription"
    private let ARG_PROFILE_AVATAR = "arg:profileAvatar"

    func save(model: ProfileViewModel) -> Bool {
        if let name = model.name {
            UserDefaults.standard.set(name, forKey: ARG_PROFILE_NAME)
        }
        if let description = model.description {
            UserDefaults.standard.set(description, forKey: ARG_PROFILE_DESCRIPTION)
        }
        if let avatar = model.avatar {
            return saveImage(image: avatar, fileName: ARG_PROFILE_AVATAR)
        }

        return true
    }

    func loadData() -> ProfileViewModel {
        let model = ProfileViewModel()
        model.name = UserDefaults.standard.string(forKey: ARG_PROFILE_NAME)
        model.description = UserDefaults.standard.string(forKey: ARG_PROFILE_DESCRIPTION)

        model.avatar = loadImage(fileName: ARG_PROFILE_AVATAR)
        return model;
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    private func loadImage(fileName: String) -> UIImage? {
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(fileName).png")
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }

    private func saveImage(image: UIImage, fileName: String) -> Bool {
        if let data = image.pngData() {
            let filename = getDocumentsDirectory().appendingPathComponent("\(fileName).png")
            do {
                try data.write(to: filename)
                return true
            } catch {
                print("Error save image : \(error)")
                return false
            }

        } else {
            return false
        }
    }
}

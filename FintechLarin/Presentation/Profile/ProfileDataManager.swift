//
//  ProfileDataManager.swift
//  FintechLarin
//
//  Created by Иван Lardis on 20/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

class ProfileDataManager {

    private let profileName = "profileName"
    private let profileDescription = "profileDescription"
    private let profileAvatar = "profileAvatar"

    func getUserName() -> String {
        return UserDefaults.standard.string(forKey: profileName) ?? UIDevice.current.name
    }

    func save(model: ProfileModel) -> Bool {
        if let name = model.name {
            UserDefaults.standard.set(name, forKey: profileName)
        }
        if let description = model.description {
            UserDefaults.standard.set(description, forKey: profileDescription)
        }
        if let avatar = model.avatar {
            return saveImage(image: avatar, fileName: profileAvatar)
        }

        return true
    }

    func loadData() -> ProfileModel {
        let model = ProfileModel()
        model.name = UserDefaults.standard.string(forKey: profileName)
        model.description = UserDefaults.standard.string(forKey: profileDescription)

        model.avatar = loadImage(fileName: profileAvatar)
        return model
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

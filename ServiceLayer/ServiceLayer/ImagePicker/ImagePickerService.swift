//
//  ImagePickerService.swift
//  ServiceLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer

class ImagePickerService: IImagePickerService {
    var network: INettwork
    var storage: IStorage
    var fileStorage: IFileStorage

    public init(network: INettwork,
                storage: IStorage,
                fileStorage: IFileStorage) {
        self.network = network
        self.storage = storage
        self.fileStorage = fileStorage
    }

    func getImageList() -> Result<ImageListModel> {
        return network.getImageList()
    }

    func getImage(url: String) -> Result<UIImage> {
        if let imageStorage = fileStorage.loadImage(fileName: url) {
            print("из истории")
            return Result.success(imageStorage)
        } else {
            print("из интернета")
            let result = network.getImage(url: url)
            switch result {
            case .success(let image):

                fileStorage.saveImage(image: image, fileName: url)
                break
            default:
                break
            }
            return result
        }
    }

    func saveImage(url: String) {
        let result = getImage(url: url)
        switch result {
        case .success(let image):
            let model = ProfileModel.init()
            model.avatar = image
            if storage.saveProfile(model: model) {
                print("сохранено")
            }
            break
        default:
            break
        }
    }
}

//
//  ImagePickerInteractor.swift
//  ImagePickerModule
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import ServiceLayer
import CoreLayer

class ImagePickerInteractor: IImagePickerInteractor {
    let service: IImagePickerService

    init(service: IImagePickerService) {
        self.service = service
    }

    func getImageList() -> Result<ImageListModel> {
        return service.getImageList()
    }

    func getImage(url: String) -> Result<UIImage> {
        return service.getImage(url: url)
    }

    func saveImage(url: String) {
        return service.saveImage(url: url)
    }
}

//
//  IImagePickerService.swift
//  ServiceLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer

public protocol IImagePickerService {
    func getImageList() -> Result<ImageListModel>
    func getImage(url: String) -> Result<UIImage>
    func saveImage(url: String)
}

//
//  IImagePickerPresenter.swift
//  ImagePickerModule
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

protocol IImagePickerPresenter {
    func getImageList()
    func getImage(cell: ImagePickerCell, url: String)
    func saveImage(url: String)
}

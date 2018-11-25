//
//  IImagePickerView.swift
//  ImagePickerModule
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer

protocol IImagePickerView: class {
    var presenter: IImagePickerPresenter? { get set }
    func show(data: ImageListModel)
    func showLoadingError(text: String)
    func showLoading(show: Bool)
    func close()
}

//
//  ImagePickerAssembly.swift
//  ImagePickerModule
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import ServiceLayer
import Router

class ImagePickerAssembly: NSObject {

    func inject(view: IImagePickerView) {
        let service: IImagePickerService = ServiceLayerAssemblyFactory.getServiceLayerAssembly()
                .getImagePickerService()
        let interactor: IImagePickerInteractor = ImagePickerInteractor.init(service: service)
        let router: IRouter = RouterAssembly.getRouter()
        let presenter: IImagePickerPresenter = ImagePickerPresenter.init(interactor: interactor,
                router: router,
                view: view)
        view.presenter = presenter
    }
}

//
//  ImagePickerPresenter.swift
//  ImagePickerModule
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import Router
import CoreLayer

class ImagePickerPresenter: IImagePickerPresenter {
    private let interactor: IImagePickerInteractor
    private let router: IRouter
    private weak var view: IImagePickerView?
    var operationQueue: OperationQueue
    var operations = [String: BlockOperation]()

    init(interactor: IImagePickerInteractor,
         router: IRouter,
         view: IImagePickerView) {
        self.interactor = interactor
        self.router = router
        self.view = view

        operationQueue = OperationQueue.init()
        operationQueue.maxConcurrentOperationCount = 10
    }

    func saveImage(url: String) {
        view?.showLoading(show: true)
        DispatchQueue.global(qos: .background).async {

            self.interactor.saveImage(url: url)
            DispatchQueue.main.async {
                self.view?.showLoading(show: false)
                self.view?.close()

            }
        }
    }

    func getImageList() {

        view?.showLoading(show: true)
        DispatchQueue.global(qos: .background).async {
            let result = self.interactor.getImageList()
            DispatchQueue.main.async {
                self.view?.showLoading(show: false)
                switch result {
                case .error(let text):
                    self.view?.showLoadingError(text: text)
                case .success(let model):
                    self.view?.show(data: model)
                }
            }
        }
    }

    func getImage(cell: ImagePickerCell, url: String) {
        let operation = BlockOperation {
            let result = self.interactor.getImage(url: url)
            DispatchQueue.main.async {
                switch result {
                case .error(let text):
                    print(text)
                    break
                case .success(let image):
                    if (cell.url == url) {
                        cell.image = image.cropToSquare()
                    }
                    break
                }
            }
        }

        cell.url = url
        operations[url] = operation
        operationQueue.addOperation(operation)
    }

    func cancelLoadImage(url: String) {
        operations[url]?.cancel()
    }
}

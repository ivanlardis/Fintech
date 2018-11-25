//
//  NetworkManager.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class NetworkManager: INettwork {
    let requestSender: IRequestSender
    let requestsFactory: RequestsFactory

    init(requestSender: IRequestSender,
         requestsFactory: RequestsFactory) {
        self.requestSender = requestSender
        self.requestsFactory = requestsFactory
    }

    func getImageList() -> Result<ImageListModel> {
        return requestSender.send(config: requestsFactory.getPixabayListImageConfig())
    }

    func getImage(url: String) -> Result<UIImage> {
        return requestSender.send(config: requestsFactory.getPixabayImageConfig(url: url))
    }
}

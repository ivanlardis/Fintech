//
//  PixabayImageRequest.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class PixabayImageRequest: IRequest {
    var urlRequest: URL?

    init(url: String) {
        urlRequest = URL.init(string: url)
    }
}

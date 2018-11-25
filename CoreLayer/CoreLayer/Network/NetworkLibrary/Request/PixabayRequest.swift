//
//  PixabayRequest.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class PixabayRequest: IRequest {
    var urlRequest: URL? = URL.init(string: "https://pixabay.com/api/?" +
            "key=10796782-80bbc5eb0d398f924fb83c8f9" +
            "&q=yellow+flowers" +
            "&image_type=%20photo" +
            "&pretty=true" +
            "&per_page=200")
}

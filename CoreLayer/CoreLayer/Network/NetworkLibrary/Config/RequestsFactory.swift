//
//  RequestsFactory.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

struct RequestsFactory {

    func getPixabayListImageConfig() -> RequestConfig<CodableParser<ImageListModel>> {
        return RequestConfig<CodableParser<ImageListModel>>(request: PixabayRequest(), parser: CodableParser<ImageListModel>())
    }

    func getPixabayImageConfig(url: String) -> RequestConfig<ImageParser> {
        return RequestConfig<ImageParser>(request: PixabayImageRequest.init(url: url),
                parser: ImageParser())
    }

}

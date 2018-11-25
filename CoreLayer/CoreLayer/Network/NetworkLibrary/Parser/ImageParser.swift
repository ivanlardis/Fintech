//
//  ImageParser.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ImageParser: IParser {
    typealias Model = UIImage

    func parse(data: Data) -> UIImage? {
        let model: UIImage? = UIImage.init(data: data)
        return model
    }
}

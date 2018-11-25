//
//  ImageCoreModel.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

public struct ImageCoreModel: Codable {
    public var webformatURL: String

    public init(webformatURL: String) {
        self.webformatURL = webformatURL
    }
}

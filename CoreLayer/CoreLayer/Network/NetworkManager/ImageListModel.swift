//
//  ImageListModel.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

public struct ImageListModel: Codable {
    public var hits: [ImageCoreModel]

    init(hits: [ImageCoreModel]) {
        self.hits = hits
    }
}

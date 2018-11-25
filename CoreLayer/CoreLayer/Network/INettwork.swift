//
//  INettwork.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

public protocol INettwork {
    func getImageList() -> Result<ImageListModel>
    func getImage(url: String) -> Result<UIImage>
}

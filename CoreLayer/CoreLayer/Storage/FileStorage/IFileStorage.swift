//
//  IFileStorage.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

public protocol IFileStorage {
    func saveImage(image: UIImage, fileName: String)
    func loadImage(fileName: String) -> UIImage?
}

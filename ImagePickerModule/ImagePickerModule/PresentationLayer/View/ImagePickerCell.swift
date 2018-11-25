//
//  ImagePickerCell.swift
//  ImagePickerModule
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ImagePickerCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var url: String?
    var image: UIImage? {
        didSet {
            if image == nil {
                let bundle = Bundle(identifier: "ivanlarin.ImagePickerModule")
                imageView.image = UIImage.init(named: "place-holder-image", in: bundle, compatibleWith: nil)
            } else {
                imageView.image = image
            }
        }
    }
}

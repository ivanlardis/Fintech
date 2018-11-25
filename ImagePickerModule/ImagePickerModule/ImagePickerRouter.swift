//
//  ImagePickerRouter.swift
//  ImagePickerModule
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import Router

public class ImagePickerRouter: IRouter {
    public init() {
    }

    public func handle(_ screen: AppScreens,
                       action: (UIViewController) -> Void
    ) -> Bool {

        if (screen == AppScreens.ImagePicker) {
            let bundle = Bundle(identifier: "ivanlarin.ImagePickerModule")
            let storyboard = UIStoryboard(name: "ImagePicker", bundle: bundle)
            if let controller = storyboard.instantiateInitialViewController() {

                action(controller)

                return true
            }
        }

        return false
    }
}


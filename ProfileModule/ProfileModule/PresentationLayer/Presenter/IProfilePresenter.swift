//
//  IProfilePresenter.swift
//  ProfileModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer

public protocol IProfilePresenter: class {
    func saveProfile(model: ProfileModel)
    func loadProfile()
    func openImagePicker()
}

//
//  IProfileService.swift
//  ServiceLayer
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer

public protocol IProfileService: class { 
    func saveProfile(model: ProfileModel)->Bool
    func  loadProfile()->ProfileModel?
}

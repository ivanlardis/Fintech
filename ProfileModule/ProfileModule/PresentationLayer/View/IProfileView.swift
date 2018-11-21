//
//  IProfileView.swift
//  ProfileModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer
public protocol  IProfileView: class {
    var profilePresenter  : IProfilePresenter? { get set }
    
    func showLoading(show: Bool)
    func showData(model: ProfileModel)
    func showSaveAction(success:Bool)
}

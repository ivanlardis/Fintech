//
//  IServiceLayerAssembly.swift
//  ServiceLayer
//
//  Created by Иван Lardis on 19/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

public protocol IServiceLayerAssembly: class {
    func getThemesService() -> IThemesService
    func getProfileService() -> IProfileService
    func getConversationService() -> IConversationService
}

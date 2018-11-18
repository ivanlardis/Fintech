//
//  ServiceLayerAssemblyFactory.swift
//  ServiceLayer
//
//  Created by Иван Lardis on 19/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer

public class ServiceLayerAssemblyFactory: NSObject {

    public static var serviceAssembly: IServiceLayerAssembly?

    public static func getServiceLayerAssembly() -> IServiceLayerAssembly {
        if let assembly = serviceAssembly {
            return assembly
        } else {
            let coreLayerAssembly: ICoreLayerAssembly = CoreLayerAssembly.init()
            let iServiceLayerAssembly: IServiceLayerAssembly = ServiceLayerAssembly.init(coreLayerAssembly: coreLayerAssembly)
            self.serviceAssembly = iServiceLayerAssembly
            return iServiceLayerAssembly
        }
    }
}

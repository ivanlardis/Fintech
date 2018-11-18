//
//  RouterAssembly.swift
//  Router
//
//  Created by Иван Lardis on 17/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

public class RouterAssembly {

    private static var iRouter: IRouter? = nil

    public static func initRouter(router: IRouter) {
        RouterAssembly.iRouter = router
    }

    public static func getRouter() -> IRouter {
        if nil == iRouter {
            print("Роутер не инициализирован работать не будет")
        }
        return iRouter!
    }

    enum RouterAssemblyError: Error {
        case noValidRouter
    }
}

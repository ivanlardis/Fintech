//
//  IRouter.swift
//  Router
//
//  Created by Иван Lardis on 08.06.18.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

public protocol IRouter {

    func handle(_ screen: AppScreens,
                action: (UIViewController) -> Void
    ) -> Bool
}

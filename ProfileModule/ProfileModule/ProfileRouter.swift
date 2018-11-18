//
//  ProfileRouter.swift
//  ProfileModule
//
//  Created by Иван Lardis on 17/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import Router
public class ProfileRouter : IRouter{
    public   init(){}
    
    public func handle (_ screen : AppScreens,
                         action : (UIViewController)->Void) -> Bool{
        
        if (screen == AppScreens.Profile ){
            let bundle = Bundle(identifier: "ivanlarin.ProfileModule")
            let storyboard = UIStoryboard(name: "Profile", bundle: bundle)
            let controller = storyboard.instantiateInitialViewController()!
          action(controller )
            return true
        }
        
        return false
    }
}


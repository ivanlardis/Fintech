//
//  ApperanceUtils.swift
//  ThemeModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ApperanceUtils: NSObject {
    
    static func configureTheme(color: UIColor) {
        UINavigationBar.appearance().backgroundColor = color
        
        let windows = UIApplication.shared.windows
        for window in windows {
            for view in window.subviews {
                view.removeFromSuperview()
                window.addSubview(view)
            }
        }
    }
}

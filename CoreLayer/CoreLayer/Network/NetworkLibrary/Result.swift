//
//  Result.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

public enum Result<T> {
    case success(T)
    case error(String)
} 

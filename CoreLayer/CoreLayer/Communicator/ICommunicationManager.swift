//
//  ICommunicationManager.swift
//  CoreLayer
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

public protocol ICommunicationManager: class {
    func sendMessage(text: String, toUserID: String)
    var communicationDelegate: ICommunicationDelegate? { set get }
}

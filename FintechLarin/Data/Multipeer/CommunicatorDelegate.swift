//
//  CommunicatorDelegate.swift
//  FintechLarin
//
//  Created by Иван Lardis on 28/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

protocol CommunicatorDelegate: class {
    
    //discovering
    func didFoundUser(userID: String, userName: String?)
    func didLostUser(userID: String)
    
    //errors
    func failedToStartBrowsingForUsers(error: Error)
    func failedToStartAdvertising(error: Error)
    
    //messages
    func didReceiveMessage(text: String, fromUser: String, toUser: String)
   
}

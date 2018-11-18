//
//  Communicator.swift
//  FintechLarin
//
//  Created by Иван Lardis on 28/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit 

public protocol Communicator {
    func sendMessage(string: String, to userID: String, completionHandler:((_ success: Bool, _ error: Error?) -> Void)?)
    var delegate: CommunicatorDelegate? {get set}
    var online: Bool {get set}
}

//
//  CommunicationManagerDelegate.swift
//  FintechLarin
//
//  Created by Иван Lardis on 12/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

protocol CommunicationManagerDelegate: class {

    func updateData(data: [String: ConversationModel])
}

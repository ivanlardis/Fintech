//
//  IMessageListView.swift
//  FintechLarin
//
//  Created by Иван Lardis on 29/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

protocol IMessageListView: class {
    func showData(models: ConversationModel)
}

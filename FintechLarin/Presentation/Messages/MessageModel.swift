//
//  MessageModel.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

class MessageModel {
    var textMessage: String
    var isIncomingMessage: Bool
    var date: Date
    var id: String

    init(textMessage: String,
         isIncomingMessage: Bool,
         date: Date,
         id: String) {
        self.textMessage = textMessage
        self.isIncomingMessage = isIncomingMessage
        self.date = date
        self.id = id
    }
}

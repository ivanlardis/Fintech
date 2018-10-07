//
//  ConversationCellModel.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

class ConversationCellModel {
    var textMessage: String
    var isIncomingMessage: Bool
    var date: Date

    init(textMessage: String,
         isIncomingMessage: Bool,
         date: Date) {
        self.textMessage = textMessage
        self.isIncomingMessage = isIncomingMessage
        self.date = date
    }
}

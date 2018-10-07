//
//  ConversationCellModel.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation


class ConversationsCellModel {
    var name: String
    var message: String?
    var date: Date
    var online: Bool
    var hasUnreadMessages: Bool

    init(name: String,
         message: String?,
         date: Date,
         online: Bool,
         hasUnreadMessages: Bool) {
        self.name = name
        self.message = message
        self.date = date
        self.online = online
        self.hasUnreadMessages = hasUnreadMessages
    }
}

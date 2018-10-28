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
    var toUserID: String
    var message: [ConversationCellModel]
    var date: Date
    var online: Bool
    var hasUnreadMessages: Bool

    init(name: String,
         date: Date,
         online: Bool,
         hasUnreadMessages: Bool,
         toUserID: String) {
        self.name = name
        message = [ConversationCellModel]()
        self.date = date
        self.online = online
        self.hasUnreadMessages = hasUnreadMessages
        self.toUserID = toUserID
    }
}

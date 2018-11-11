//
//  MessageModel.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

class ConversationModel {

    var name: String
    var conversationId: String
    var message: [MessageModel]
    var date: Date
    var online: Bool
    var hasUnreadMessages: Bool

    init(name: String,
         date: Date,
         online: Bool,
         hasUnreadMessages: Bool,
         conversationId: String) {
        self.name = name
        message = [MessageModel]()
        self.date = date
        self.online = online
        self.hasUnreadMessages = hasUnreadMessages
        self.conversationId = conversationId
    }
}

//
//  MessageModel.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

public class ConversationModel {

    public var name: String
    public var conversationId: String
    public var message: [MessageModel]
    public var date: Date
    public var online: Bool
    public var hasUnreadMessages: Bool

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

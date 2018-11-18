//
//  MessageModel.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

public class MessageModel {
    public var textMessage: String
    public var isIncomingMessage: Bool
    public var date: Date
    public var messageId: String

    init(textMessage: String,
         isIncomingMessage: Bool,
         date: Date,
         messageId: String) {
        self.textMessage = textMessage
        self.isIncomingMessage = isIncomingMessage
        self.date = date
        self.messageId = messageId
    }
}

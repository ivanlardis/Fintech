//
//  ConversationIncomingCell.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ConversationIncomingCell: UITableViewCell, ConversationCellConfiguration {

    @IBOutlet weak var messageLabel: UILabel!

    var textMessage: String? {
        set(newMessage) {
            if (newMessage == nil) {
                messageLabel.text = "No messages yet"
            } else {
                messageLabel.text = newMessage
            }
        }
        get {
            return messageLabel.text
        }
    }
}


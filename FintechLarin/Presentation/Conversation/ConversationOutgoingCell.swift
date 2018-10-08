//
//  ConversationOutgoingCell.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ConversationOutgoingCell: UITableViewCell, ConversationCellConfiguration {

    @IBOutlet weak var messageLabel: UILabel!

    var textMessage: String? {
        didSet {
            if (textMessage == nil) {
                messageLabel.text = "No messages yet"
            } else {
                messageLabel.text = textMessage
            }
        }
    }
}

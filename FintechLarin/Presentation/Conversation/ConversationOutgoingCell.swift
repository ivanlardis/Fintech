//
//  ConversationOutgoingCell.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ConversationOutgoingCell: UITableViewCell, ConversationCellConfiguration {

    let dateFormatter = DateFormatter()

    @IBOutlet weak var timeLabel: UILabel!
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

    var date: Date? {
        didSet {
            guard let date = date else {
                timeLabel.text = nil
                return
            }

            if Calendar.current.isDateInToday(date) {
                dateFormatter.dateFormat = "HH:mm"
            } else {
                dateFormatter.dateFormat = "dd MMM"
            }

            timeLabel.text = dateFormatter.string(from: date)
        }
    }
}

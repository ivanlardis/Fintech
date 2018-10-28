//
//  ConversationsCell.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ConversationsCell: UITableViewCell, ConversationsCellConfiguration {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var view: UIView!
    let dateFormatter = DateFormatter()


    var toUserID: String?

    var message: String? {
        didSet {
            if (message == nil) {
                messageLabel.text = "No messages yet"
            } else {
                messageLabel.text = message
            }
        }
    }

    var name: String? {
        didSet {
            nameLabel.text = name
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

    var online: Bool = false {
        didSet {
            let yellowColor = UIColor.init(red: 247 / 255.0, green: 245 / 255.0, blue: 215 / 255.0, alpha: 1.0)
            view.backgroundColor = online ? yellowColor : .white
        }
    }

    var hasUnreadMessages: Bool = false {
        didSet(isUnreadMessages) {
            messageLabel.font = hasUnreadMessages ? UIFont.boldSystemFont(ofSize: 18.0) : UIFont.systemFont(ofSize: 16.0)
        }
    }
}

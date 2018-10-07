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

    var message: String? {
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

    var name: String? {
        set(newName) {
            nameLabel.text = newName
        }
        get {
            return nameLabel.text
        }
    }


    var date: Date? {
        get {
            if let timeText = timeLabel.text {
                return dateFormatter.date(from: timeText)
            }
            return nil
        }

        set(newDate) {
            guard let date = newDate else {
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

    var online: Bool {
        set(isOnline) {
            let yellowColor = UIColor.init(red: 247 / 255.0, green: 245 / 255.0, blue: 215 / 255.0, alpha: 1.0)
            view.backgroundColor = isOnline ? yellowColor : .white
        }
        get {
            return view.backgroundColor != .white
        }
    }

    var hasUnreadMessages: Bool {
        set(isUnreadMessages) {
            messageLabel.font = isUnreadMessages ? UIFont.boldSystemFont(ofSize: 18.0) : UIFont.systemFont(ofSize: 16.0)
        }
        get {
            return messageLabel.font.pointSize == 18
        }
    }
}

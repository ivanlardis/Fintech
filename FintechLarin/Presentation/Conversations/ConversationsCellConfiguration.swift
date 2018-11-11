//
// Created by Иван Lardis on 06/10/2018.
// Copyright (c) 2018 ivan larin. All rights reserved.
//

import Foundation

protocol ConversationsCellConfiguration: class {
    var name: String? { get set }
    var message: String? { get set }
    var date: Date? { get set }
    var online: Bool { get set }
    var hasUnreadMessages: Bool { get set }
    var toUserID: String? { get set }
}

//
//  Message.swift
//  FintechLarin
//
//  Created by Иван Lardis on 12/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation
import CoreData

extension Message {

    class func fetchRequestById(messageId: String) -> NSFetchRequest<Message>? {
        var fetchRequest: NSFetchRequest<Message> = Message.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "messageId == %@", messageId)

        return fetchRequest
    }
}

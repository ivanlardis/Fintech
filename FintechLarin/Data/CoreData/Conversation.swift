//
//  Conversation.swift
//  FintechLarin
//
//  Created by Иван Lardis on 12/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation
import CoreData

extension Conversation {

    class func fetchRequestById(conversationId: String) -> NSFetchRequest<Conversation>? {
        var fetchRequest: NSFetchRequest<Conversation> = Conversation.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "conversationId == %@", conversationId)

        return fetchRequest
    }
}

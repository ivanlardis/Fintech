//
//  User.swift
//  FintechLarin
//
//  Created by Иван Lardis on 12/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation
import CoreData

extension User {

    class func fetchRequestById(userId: String) -> NSFetchRequest<User>? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %@", userId)
        return fetchRequest
    }
}

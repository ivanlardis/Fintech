//
//  IConversationPresenter.swift
//  ConversationModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer
import CoreData


protocol IConversationPresenter: class {

    func openProfile()
    func openTheme()
    func getConversationFRC() -> NSFetchedResultsController<Conversation>
}

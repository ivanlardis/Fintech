//
//  MessageTableViewDataSource.swift
//  FintechLarin
//
//  Created by Иван Lardis on 12/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

//
//  TableViewDataSource.swift
//  FintechLarin
//
//  Created by Иван Lardis on 11/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreData

class MessageTableViewDataSource: NSObject, UITableViewDataSource {
    let fetchedResultsController: NSFetchedResultsController<Message>

    init(fetchedResultsController: NSFetchedResultsController<Message>) {
        self.fetchedResultsController = fetchedResultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.fetchedResultsController.object(at: indexPath)
        let idCell = message.isIncomingMessage ? "ConversationIncomingCell" : "ConversationOutgoingCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath)

        if let conversationCell = cell as? MessageCellConfiguration {
            conversationCell.textMessage = message.text
            conversationCell.date = message.date
        }
        return cell
    }
}

//
//  TableViewDataSource.swift
//  FintechLarin
//
//  Created by Иван Lardis on 11/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreData

class TableViewDataSource: NSObject, UITableViewDataSource {

    let fetchedResultsController: NSFetchedResultsController<Conversation>

    private let cellIdentifier = "UserCell"

    init(fetchedResultsController: NSFetchedResultsController<Conversation>) {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationsCell", for: indexPath)

        let conversation = self.fetchedResultsController.object(at: indexPath)

        if let conversationCell = cell as? ConversationCellConfiguration {
            conversationCell.online = conversation.online
            conversationCell.name = conversation.user?.userName
            conversationCell.toUserID = conversation.user?.id
            conversationCell.message = conversation.lastMessage?.text
            conversationCell.date = conversation.lastMessage?.date
        }
        return cell
    }

}


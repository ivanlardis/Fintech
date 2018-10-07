//
//  ConversationViewController.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var data = [ConversationCellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        getData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = data[indexPath.row]
        let idCell = model.isIncomingMessage ? "ConversationIncomingCell" : "ConversationOutgoingCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath)

        if let conversationCell = cell as? ConversationCellConfiguration {
            conversationCell.textMessage = model.textMessage
        }
        return cell
    }

    func getData() {
        showData(models: TestData.init().getConversationTesttData())
    }

    func showData(models: [ConversationCellModel]) {
        let sortModels = models.sorted {
            $0.date.timeIntervalSinceNow < $1.date.timeIntervalSinceNow
        }

        data = sortModels

        tableView.reloadData()
    }
}


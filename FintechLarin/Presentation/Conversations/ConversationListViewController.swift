//
//  ConversationViewController.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ConversationListViewController: UIViewController,
        UITableViewDataSource,
        UITableViewDelegate,
        IConversationListView {

    @IBOutlet weak var tableView: UITableView!

    var themeManager: ThemesManager = ThemesManager()
    var data = [TableStruct]()
    var communicationManager: CommunicationManager?

    struct TableStruct {
        var sectionName: String
        var sectionObjects: [ConversationsCellModel]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ConversationDI.inject(viewController: self)

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        communicationManager?.updateData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].sectionObjects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationsCell", for: indexPath)

        let cellModel = getCellModel(indexPath: indexPath)

        if let conversationCell = cell as? ConversationsCellConfiguration {
            conversationCell.online = cellModel.online
            conversationCell.name = cellModel.name
            conversationCell.date = cellModel.date
            conversationCell.toUserID = cellModel.toUserID
            conversationCell.hasUnreadMessages = cellModel.hasUnreadMessages

            let lastMessage = cellModel.message.sorted {
                $0.date.timeIntervalSinceNow < $1.date.timeIntervalSinceNow
            }.last
            conversationCell.message = lastMessage?.textMessage ?? "No message"

            conversationCell.date = lastMessage?.date
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].sectionName
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConversationSegua",
           let cell = sender as? ConversationsCell {
            segue.destination.navigationItem.title = cell.name

            if let viewControler = segue.destination as? ConversationViewController {
                viewControler.toUserID = cell.toUserID
            }

        } else if segue.identifier == "ThemeViewSegua" {

            if let navigationController = segue.destination as? UINavigationController,
               let viewControlerSwift = navigationController.topViewController as? ThemesViewController {
                viewControlerSwift.themeClosure = { [unowned self] (controller, color) in
                    self.themeManager.handleTheme(controller, color)
                }
            } else {
                print("Ошибка в сториборде  ThemesViewController нужно выберать модуль FintechLarin")
            }

        } else {
            super.prepare(for: segue, sender: sender)
        }
    }

    private func getCellModel(indexPath: IndexPath) -> ConversationsCellModel {
        let sectionModel = data[indexPath.section].sectionObjects
        let cellModel = sectionModel[indexPath.row]
        return cellModel
    }

    func getLastMessage(model: ConversationsCellModel) -> ConversationCellModel? {
        return model.message.sorted {
            $0.date.timeIntervalSinceNow < $1.date.timeIntervalSinceNow
        }.last
    }

    func sortedModel(model1: ConversationsCellModel,
                     model2: ConversationsCellModel) -> Bool {

        let message1 = getLastMessage(model: model1)
        let message2 = getLastMessage(model: model2)

        if let mess1 = message1,
           let mess2 = message2 {
            return mess1.date.timeIntervalSinceNow > mess2.date.timeIntervalSinceNow
        } else if message1 == nil && message2 == nil {
            return model1.name < model2.name
        } else if message2 == nil {
            return true
        } else {
            return false
        }
    }

    func showData(models: [ConversationsCellModel]) {

        let sortModels = models.sorted {
            sortedModel(model1: $0, model2: $1)
        }

        let online = sortModels
                .filter {
            $0.online == true
        }

        let offline = sortModels.filter {
            $0.online == false
        }

        data.removeAll()
        if online.count > 0 {
            data.append(TableStruct.init(sectionName: "Online", sectionObjects: online))
        }

        if offline.count > 0 {
            data.append(TableStruct.init(sectionName: "Offline", sectionObjects: offline))
        }

        tableView.reloadData()
    }

    deinit {
        ConversationDI.reject(viewController: self)
    }
}

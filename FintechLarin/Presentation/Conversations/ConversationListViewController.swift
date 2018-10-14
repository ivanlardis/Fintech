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
        UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var themeManager: ThemesManager = ThemesManager()
    var data = [TableStruct]()

    struct TableStruct {
        var sectionName: String
        var sectionObjects: [ConversationsCellModel]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        getData()
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
            conversationCell.hasUnreadMessages = cellModel.hasUnreadMessages
            conversationCell.message = cellModel.message
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
        if segue.identifier == "ConversationSegua" {
            let cell = sender as! ConversationsCell
            segue.destination.navigationItem.title = cell.name
        } else if segue.identifier == "ThemeViewSegua" {

            #if THEMEOBJ

            if let viewControlerObj = segue.destination as? ThemesViewController {
                viewControlerObj.delegate = self.themeManager
            } else {
                print("Ошибка в сториборде  ThemesViewController нужно выберать модуль None")
            }

            #endif

            #if THEMESWIFT

            if let viewControlerSwift = segue.destination as? ThemesViewController {
                viewControlerSwift.themeClosure = { [unowned self] (controller, color) in
                    self.themeManager.handleTheme(controller, color)
                }
            } else {
                print("Ошибка в сториборде  ThemesViewController нужно выберать модуль FintechLarin")
            }

            #endif

        } else {
            super.prepare(for: segue, sender: sender)
        }
    }

    private func getCellModel(indexPath: IndexPath) -> ConversationsCellModel {
        let sectionModel = data[indexPath.section].sectionObjects
        let cellModel = sectionModel[indexPath.row]
        return cellModel
    }

    func getData() {
        showData(models: TestData.init().getConversationTestListData())
    }

    func showData(models: [ConversationsCellModel]) {
        let sortModels = models.sorted {
            $0.date.timeIntervalSinceNow < $1.date.timeIntervalSinceNow
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
}

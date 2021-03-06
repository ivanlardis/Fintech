//
//  MessageListViewController.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreData
import ServiceLayer
import CoreLayer
import Router

class ConversationListViewController: UIViewController,
        UITableViewDelegate,
        NSFetchedResultsControllerDelegate,
        IConversationListView {

    @IBOutlet weak var tableView: UITableView!


    public var presenter: IConversationPresenter?

    @IBAction func actionOpenProfile(_ sender: Any) {
        presenter?.openProfile()
    }

    func present(viewControllerToPresent: UIViewController) {
        present(viewControllerToPresent, animated: true, completion: nil)
    }

    @IBAction func actionOpenTheme(_ sender: Any) {
        presenter?.openTheme()
    }

    var data = [TableStruct]()


    struct TableStruct {
        var sectionName: String
        var sectionObjects: [ConversationModel]
    }

    private lazy var tableViewDataSource: UITableViewDataSource = {


        let fetchedResultsController = presenter!.getConversationFRC()
        fetchedResultsController.delegate = self

        let conversationDataSource = TableViewDataSource(fetchedResultsController: fetchedResultsController)

        fetchedResultsController.delegate = self

        return conversationDataSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        ConversationAssembly.init().inject(view: self)
        self.tableView.delegate = self
        self.tableView.dataSource = self.tableViewDataSource


        self.tableView.rowHeight = UITableView.automaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConversationSegua",
           let cell = sender as? ConversationCell {
            segue.destination.navigationItem.title = cell.name

            if let viewControler = segue.destination as? MessageListViewController,
               let toUserID = cell.toUserID {
                viewControler.toUserID = toUserID
                viewControler.online = cell.online
            }

        } else {
            super.prepare(for: segue, sender: sender)
        }
    }

    private func getCellModel(indexPath: IndexPath) -> ConversationModel {
        let sectionModel = data[indexPath.section].sectionObjects
        let cellModel = sectionModel[indexPath.row]
        return cellModel
    }

    func getLastMessage(model: ConversationModel) -> MessageModel? {
        return model.message.sorted {
            $0.date.timeIntervalSinceNow < $1.date.timeIntervalSinceNow
        }.last
    }

    func sortedModel(model1: ConversationModel,
                     model2: ConversationModel) -> Bool {

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

    func showData(models: [ConversationModel]) {

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


    func controller(
            _ controller: NSFetchedResultsController<NSFetchRequestResult>,
            didChange anObject: Any,
            at indexPath: IndexPath?,
            for type: NSFetchedResultsChangeType,
            newIndexPath: IndexPath?) {
        print("\(#function)")
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        }
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("\(#function)")
        self.tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("\(#function)")
        self.tableView.endUpdates()
    }
}

//
//  IConversationListView.swift
//  FintechLarin
//
//  Created by Иван Lardis on 28/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer
import CoreData

protocol IConversationListView: NSFetchedResultsControllerDelegate {

    var tableView: UITableView! { get set }
    var presenter: IConversationPresenter? { get set }

    func present(viewControllerToPresent: UIViewController)
    func showData(models: [ConversationModel])
}

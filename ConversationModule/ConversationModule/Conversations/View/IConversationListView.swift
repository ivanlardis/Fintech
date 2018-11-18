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

protocol IConversationListView: class {

    func present(viewControllerToPresent: UIViewController)
    var presenter: IConversationPresenter? { get set }
    func showData(models: [ConversationModel])
}

//
//  ConversationPresenter.swift
//  ConversationModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import Router
import CoreData
import CoreLayer

class ConversationPresenter: IConversationPresenter {

    let interactor: IConversationInteractor
    let router: IRouter
    weak var view: IConversationListView?

    init(interactor: IConversationInteractor,
         router: IRouter,
         view: IConversationListView) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }

    func getConversationFRC() -> NSFetchedResultsController<Conversation> {
        return interactor.getConversationFRC()
    }

    func openTheme() {
        open(screen: AppScreens.Theme)
    }

    func openProfile() {
        open(screen: AppScreens.Profile)
    }

    func open(screen: AppScreens) {
        let succes = router.handle(screen) {
            viewController in
            view?.present(viewControllerToPresent: viewController)
        }
        if succes {
            print("роутер отработал")
        }
    }
}

//
//  MessagePresenter.swift
//  ConversationModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import Router
import CoreData
import CoreLayer

class MessagePresenter: IMessagePresenter {
    let interactor: IMessageInteractor
    let router: IRouter
    weak var view: IMessageListView?

    init(interactor: IMessageInteractor,
         router: IRouter,
         view: IMessageListView) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }

    func sendMessage(text: String, toUserID: String) {
        interactor.sendMessage(text: text, toUserID: toUserID)
    }

    func getMessageFRC(conversationId: String) -> NSFetchedResultsController<Message> {
        return interactor.getMessageFRC(conversationId: conversationId)
    }

}

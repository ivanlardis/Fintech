//
//  ConversationAssembly.swift
//  ConversationModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import Router
import ServiceLayer

class ConversationAssembly: NSObject {
    func inject(view: IConversationListView) {
        let service: IConversationService = ServiceLayerAssemblyFactory.getServiceLayerAssembly().getConversationService()
        let interactor: IConversationInteractor = ConversationInteractor.init(service: service)
        let router: IRouter = RouterAssembly.getRouter()
        let presenter: IConversationPresenter = ConversationPresenter.init(interactor: interactor,
                router: router,
                view: view)
        view.presenter = presenter
    }
}

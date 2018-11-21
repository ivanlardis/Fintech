//
//  MessageAssembly.swift
//  ConversationModule
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import ServiceLayer
import Router

class MessageAssembly: NSObject {
    func inject(view: IMessageListView) {
        let service: IConversationService = ServiceLayerAssemblyFactory.getServiceLayerAssembly()
            .getConversationService()
        let interactor: IMessageInteractor = MessageInteractor.init(service: service)
        let router: IRouter = RouterAssembly.getRouter()
        
        let presenter: IMessagePresenter = MessagePresenter.init(interactor: interactor,
                                                                 router: router,
                                                                 view: view)
        view.presenter = presenter
    }
}

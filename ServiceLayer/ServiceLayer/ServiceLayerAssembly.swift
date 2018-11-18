//
//  ServiceLayerAssembly.swift
//  ServiceLayer
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer

public class ServiceLayerAssembly: IServiceLayerAssembly {

    let coreLayerAssembly: ICoreLayerAssembly

    public init(coreLayerAssembly: ICoreLayerAssembly) {
        self.coreLayerAssembly = coreLayerAssembly
    }

    private lazy var themesService: IThemesService = {
        return ThemesService.init(keyValueStorage: coreLayerAssembly.getKeyValueStorage())
    }()

    private lazy var profileService: IProfileService = {
        return ProfileService.init(storage: coreLayerAssembly.getStorage())
    }()

    private lazy var conversationService: IConversationService = {
        let communication = coreLayerAssembly.getCommunication()
        let conversationService = ConversationService.init(communication: communication,
                storage: coreLayerAssembly.getStorage())
        communication.communicationDelegate = conversationService
        return conversationService
    }()

    public func getThemesService() -> IThemesService {
        return themesService
    }

    public func getProfileService() -> IProfileService {
        return profileService
    }

    public func getConversationService() -> IConversationService {
        return conversationService
    }
}

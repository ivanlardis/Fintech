//
//  CoreLayerAssembly.swift
//  CoreLayer
//
//  Created by Иван Lardis on 18/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

public class CoreLayerAssembly: ICoreLayerAssembly {
    public init() {
    }

    private lazy var keyValueStorage: IKeyValueStorage = {
        return UserDefaultWrapper.init()
    }()

    private lazy var storage: IStorage = {
        let coreDataStack = CoreDataStack.init()
        return CoreDataManager.init(coreDataStack: coreDataStack)
    }()

    private lazy var communicationManager: ICommunicationManager = {
        let communicator: ICommunicator = MultipeerCommunicator.init()
        return CommunicationManager.init(communicator: communicator)
    }()

    public func getKeyValueStorage() -> IKeyValueStorage {
        return keyValueStorage
    }

    public func getStorage() -> IStorage {
        return storage
    }

    public func getCommunication() -> ICommunicationManager {
        return communicationManager
    }
}

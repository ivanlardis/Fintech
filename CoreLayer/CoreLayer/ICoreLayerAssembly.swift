//
//  ICoreLayerAssembly.swift
//  CoreLayer
//
//  Created by Иван Lardis on 19/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

public protocol ICoreLayerAssembly: class {
    func getKeyValueStorage() -> IKeyValueStorage
    func getStorage() -> IStorage
    func getNettwork() -> INettwork
    func getCommunication() -> ICommunicationManager
    func getFileStorage() -> IFileStorage
}

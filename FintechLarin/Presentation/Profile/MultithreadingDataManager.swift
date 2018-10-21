//
//  MultithreadingDataManager.swift
//  FintechLarin
//
//  Created by Иван Lardis on 20/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation


protocol MultithreadingDataManager {
    func save(model:ProfileViewModel, callback: @escaping (Bool)->Void)
    func loadData(callback: @escaping (ProfileViewModel)->Void)
}

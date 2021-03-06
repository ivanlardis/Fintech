//
//  CoreDataStack.swift
//  FintechLarin
//
//  Created by Иван Lardis on 05/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataStack: NSObject {

    // MARK: - NSPersistentStore
    private var storeURL: URL {
        let documentsDirURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = documentsDirURL.appendingPathComponent("Store.sqlite")
        return url
    }

    // MARK: - NSManagedObjectModel
    private let managedObjectModelName = "CoreDataModel"
    private var _managedObjectModel: NSManagedObjectModel?
    private var managedObjectModel: NSManagedObjectModel? {
        if _managedObjectModel == nil {
            guard let bundle = Bundle.init(identifier: "ivanlarin.CoreLayer"),
                  let modelURL = bundle.url(forResource: managedObjectModelName, withExtension: "momd") else {
                print("Empty model url!")
                return nil
            }

            _managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        }
        return _managedObjectModel
    }

    // MARK: - NSPersistentStoreCoordinator
    private var _persistentStoreCoordinator: NSPersistentStoreCoordinator?
    private var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        if _persistentStoreCoordinator == nil {
            guard let model = self.managedObjectModel else {
                print("Empty managed object model")
                return nil
            }
            _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)

            do {
                try _persistentStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType,
                        configurationName: nil,
                        at: storeURL,
                        options: nil)
            } catch {
                assert(false, "Error adding persistent store to coordinator: \(error)")
            }
        }
        return _persistentStoreCoordinator
    }

    // MARK: - NSManagedObjectContext (Master)
    private var _masterContext: NSManagedObjectContext?
    private var masterContext: NSManagedObjectContext? {
        if _masterContext == nil {
            let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            guard let persistentStore = self.persistentStoreCoordinator else {
                print("Empty persistent store coordinator!")
                return nil
            }
            context.persistentStoreCoordinator = persistentStore
            context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            context.undoManager = nil
            _masterContext = context
        }
        return _masterContext
    }

    // MARK: - NSManagedObjectContext (Main)
    private var _mainContext: NSManagedObjectContext?
    public var mainContext: NSManagedObjectContext? {
        if _mainContext == nil {
            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            guard let parentContext = self.masterContext else {
                print("No master context!")
                return nil
            }

            context.parent = parentContext
            context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            context.undoManager = nil

            _mainContext = context
        }
        return _mainContext
    }

    // MARK: - NSManagedObjectContext (Save)
    private var _saveContext: NSManagedObjectContext?
    public var saveContext: NSManagedObjectContext? {
        if _saveContext == nil {
            let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            guard let parentContext = self.mainContext else {
                print("No main context!")
                return nil
            }
            context.parent = parentContext
            context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            context.undoManager = nil

            _saveContext = context
        }
        return _saveContext
    }

    // MARK: - NSManagedObjectContext (Save)
    public func performSave(context: NSManagedObjectContext, completionHandler: (() -> Void)?) {

        context.perform { [weak self] in
            if context.hasChanges {

                do {
                    try context.save()
                } catch {
                    print("Context save error: \(error)")
                }

                if let parent = context.parent {
                    self?.performSave(context: parent, completionHandler: completionHandler)
                } else {
                    completionHandler?()
                }

            } else {
                completionHandler?()
            }
        }
    }
}

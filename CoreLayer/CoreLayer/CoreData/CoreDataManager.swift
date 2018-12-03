//
//  CoreDataManager.swift
//  FintechLarin
//
//  Created by Иван Lardis on 05/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataManager: IStorage {

    private let coreDataStack: CoreDataStack

    public init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }

    private func updateMessage(context: NSManagedObjectContext,
                               messageModel: MessageModel,
                               conversion: Conversation?,
                               isLast: Bool,
                               online: Bool) {

        let message: Message? = self.findOrCreate(in: context, idModel: messageModel.messageId)
        message?.conversationId = conversion?.id
        message?.conversation = conversion
        message?.id = messageModel.messageId
        message?.text = messageModel.textMessage
        message?.isIncomingMessage = messageModel.isIncomingMessage
        message?.date = messageModel.date
        message?.online = online
        if isLast {
            conversion?.lastMessage = message
        }
    }

    private func updateConversation(context: NSManagedObjectContext, model: ConversationModel) {

        let conversion: Conversation? = self.findOrCreate(in: context, idModel: model.conversationId)

        let user: User? = self.findOrCreate(in: context, idModel: model.conversationId)
        user?.id = model.conversationId

        user?.userName = model.name
        conversion?.user = user
        conversion?.online = model.online
        conversion?.id = model.conversationId

        let lastMessage = model.message.sorted {
            $0.date.timeIntervalSinceNow < $1.date.timeIntervalSinceNow
        }.last

        if let message = lastMessage {
            updateMessage(context: context,
                    messageModel: message,
                    conversion: conversion,
                    isLast: true,
                    online: model.online)
        }
        model.message.forEach { (messageModel: MessageModel) in

            updateMessage(context: context,
                    messageModel: messageModel,
                    conversion: conversion,
                    isLast: false,
                    online: model.online)
        }
    }

    public func updateConversations(models: [ConversationModel]) {
        print("updateConversations \(models.count)")
        if let saveContext = self.coreDataStack.saveContext {
            saveContext.perform {
                models.forEach { (model: ConversationModel) in

                    self.updateConversation(context: saveContext, model: model)
                }

                self.coreDataStack.performSave(context: saveContext, completionHandler: {})

            }
        }
    }

    public func getMessageFRC(conversationId: String) -> NSFetchedResultsController<Message> {
        let context = coreDataStack.mainContext!

        let request: NSFetchRequest<Message> = Message.fetchRequest()

        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.predicate = NSPredicate(format: "conversationId == %@", conversationId)
        request.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil)
        return fetchedResultsController
    }

    public func getConversationFRC() -> NSFetchedResultsController<Conversation> {
        print("\(#function)")
        let context = coreDataStack.mainContext!

        let request: NSFetchRequest<Conversation> = Conversation.fetchRequest()

        do {
            let results = try context.fetch(request)
            print("do \(results.count)")
        } catch {
            print("catch \(error)")
        }

        let sortOnlineDescriptor = NSSortDescriptor(key: "online", ascending: false)
        let sortDescriptor = NSSortDescriptor(key: "user.userName", ascending: true)
        request.sortDescriptors = [sortOnlineDescriptor, sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil)
        return fetchedResultsController
    }

    // MARK: получения беседы (Conversation) с определенным conversationId
    // получения message с определенным id
    // получения пользователя с определенным userId
    func fetchRequestById<T: NSManagedObject>(idModel: String) -> NSFetchRequest<T>? {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.predicate = NSPredicate(format: "id == %@", idModel)
        return fetchRequest
    }

    func findOrCreate<T: NSManagedObject>(in context: NSManagedObjectContext, idModel: String) -> T? {

        var model: T?

        guard let fetchRequest: NSFetchRequest<T> = self.fetchRequestById(idModel: idModel) else {
            return nil
        }

        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2, "Multiple Conversation found!")
            if let foundModel = results.first {
                model = foundModel
            }
        } catch {
            print("Failed to fetch profile: \(error)")
        }

        if model == nil {
            model = NSEntityDescription.insertNewObject(forEntityName: String(describing: T.self), into: context) as? T

        }
        return model
    }

    static func insertDefaultUser(in context: NSManagedObjectContext) -> AppUser? {
        let defaultAppUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser

        let defaultUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User
        defaultUser?.userName = "IvanLardis"
        defaultUser?.userDescription = "Много текста и т д. Много текста и т д. "
        defaultUser?.userAvatar = UIImage(named: "placeholder-user")?.jpegData(compressionQuality: 1)
        defaultAppUser?.currentUser = defaultUser
        return defaultAppUser
    }

    static func findOrInsertDefaultUser(in context: NSManagedObjectContext) -> AppUser? {
        var profile: AppUser?

        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2, "Multiple profiles found!")
            if let foundProfile = results.first {
                profile = foundProfile
            }
        } catch {
            print("Failed to fetch profile: \(error)")
        }

        if profile == nil {
            profile = insertDefaultUser(in: context)
        }
        return profile
    }

    // MARK: - созранение профиля
    public func saveProfile(model: ProfileModel) -> Bool {

        if let saveContext = self.coreDataStack.saveContext {
            saveContext.performAndWait {
                if let userCoreData = CoreDataManager.findOrInsertDefaultUser(in: saveContext),
                   let currentUser = userCoreData.currentUser {

                    if let profileName = model.name {
                        currentUser.userName = profileName
                    }

                    if let profileDescription = model.description {
                        currentUser.userDescription = profileDescription
                    }

                    if let profileImage = model.avatar {
                        currentUser.userAvatar = profileImage.jpegData(compressionQuality: 1.0)!
                    }

                    self.coreDataStack.performSave(context: saveContext, completionHandler: {})
                }
            }
            return true
        }
        return false
    }

    public func loadProfile() -> ProfileModel? {
        if let mainContext = self.coreDataStack.saveContext {

            let userCoreData = CoreDataManager.findOrInsertDefaultUser(in: mainContext)

            let profile = ProfileModel.init()
            let currentAppUser = userCoreData?.currentUser
            profile.description = currentAppUser?.userDescription
            profile.name = currentAppUser?.userName
            if let coreDataAvatar = currentAppUser?.userAvatar {
                profile.avatar = UIImage.init(data: coreDataAvatar)
            }
            return profile
        }

        return nil
    }
}

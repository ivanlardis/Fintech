//
// Created by Иван Lardis on 06/10/2018.
// Copyright (c) 2018 ivan larin. All rights reserved.
//

import Foundation


class TestData {

    func getConversationTestListData() -> [ConversationsCellModel] {
        return [
            ConversationsCellModel.init(name: "Мама",
                    message: "Привет от мамы",
                    date: Date(),
                    online: true,
                    hasUnreadMessages: true),

            ConversationsCellModel.init(name: "Папа ",
                    message: "Привет от папы приди вовремя и т д",
                    date: generateRandomDate(daysBack: 11),
                    online: true,
                    hasUnreadMessages: true),

            ConversationsCellModel.init(name: "Серега Евгеньевич Смирнов-Иванов-Храпов",
                    message: nil,
                    date: generateRandomDate(daysBack: 11),
                    online: true,
                    hasUnreadMessages: false),

            ConversationsCellModel.init(name: "Мария",
                    message: "Привет от Мария  приди вовремя и т д",
                    date: generateRandomDate(daysBack: 0),
                    online: true,
                    hasUnreadMessages: false),

            ConversationsCellModel.init(name: "Илья",
                    message: "Привет от Илья",
                    date: generateRandomDate(daysBack: 11),
                    online: false,
                    hasUnreadMessages: true),

            ConversationsCellModel.init(name: "Алексей",
                    message: "Привет от Алексей  приди вовремя и т д",
                    date: generateRandomDate(daysBack: 0),
                    online: false,
                    hasUnreadMessages: false),

            ConversationsCellModel.init(name: "Антон",
                    message: "Привет от Антон",
                    date: generateRandomDate(daysBack: 11),
                    online: false,
                    hasUnreadMessages: false),

            ConversationsCellModel.init(name: "Глеб",
                    message: "Привет от Глеб  приди вовремя и т д",
                    date: Date(),
                    online: false,
                    hasUnreadMessages: true),
            ConversationsCellModel.init(name: "Иван",
                    message: "Привет от Иван  приди вовремя и т д",
                    date: generateRandomDate(daysBack: 11),
                    online: true,
                    hasUnreadMessages: true),

            ConversationsCellModel.init(name: "Чебурашка",
                    message: "Привет от Чебурашка",
                    date: generateRandomDate(daysBack: 11),
                    online: true,
                    hasUnreadMessages: false),

            ConversationsCellModel.init(name: "Гена",
                    message: "Привет от Гена  приди вовремя и т д",
                    date: generateRandomDate(daysBack: 0),
                    online: true,
                    hasUnreadMessages: true),

            ConversationsCellModel.init(name: "Смешарие",
                    message: "Привет от Смешарие",
                    date: generateRandomDate(daysBack: 11),
                    online: true,
                    hasUnreadMessages: false),

            ConversationsCellModel.init(name: "Кактус",
                    message: nil,
                    date: generateRandomDate(daysBack: 11),
                    online: false,
                    hasUnreadMessages: false),
            ConversationsCellModel.init(name: "Президент",
                    message: "Привет от Президент  приди вовремя и т д",
                    date: Date(),
                    online: false,
                    hasUnreadMessages: true),

            ConversationsCellModel.init(name: "Олег",
                    message: "Привет от Олег",
                    date: generateRandomDate(daysBack: 0),
                    online: false,
                    hasUnreadMessages: false),

            ConversationsCellModel.init(name: "Клоун",
                    message: "Привет от Клоун",
                    date: generateRandomDate(daysBack: 11),
                    online: false,
                    hasUnreadMessages: false),

            ConversationsCellModel.init(name: "Техцент",
                    message: "Привет от Техцент  приди вовремя и т д",
                    date: generateRandomDate(daysBack: 11),
                    online: true,
                    hasUnreadMessages: true),

            ConversationsCellModel.init(name: "Аноним",
                    message: "Привет от Аноним",
                    date: Date(),
                    online: true,
                    hasUnreadMessages: true),
        ]
    }

    func getConversationTesttData() -> [ConversationCellModel] {
        return [

            ConversationCellModel.init(textMessage: "Привет Как дела",
                    isIncomingMessage: true,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "Хорошо у тебя",
                    isIncomingMessage: false,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "Погода Хорошая",
                    isIncomingMessage: true,
                    date: generateRandomDate(daysBack: 5)),
            ConversationCellModel.init(textMessage: "Что будем делать",
                    isIncomingMessage: false,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "Хабиб выграл",
                    isIncomingMessage: true,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "Хорошо у тебя у меня тоже все хорошо и т д",
                    isIncomingMessage: false,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "Конор проиграл",
                    isIncomingMessage: true,
                    date: generateRandomDate(daysBack: 5)),
            ConversationCellModel.init(textMessage: "Москва 5 градусов",
                    isIncomingMessage: false,
                    date: generateRandomDate(daysBack: 5)),


            ConversationCellModel.init(textMessage: "Новый айфон не новый",
                    isIncomingMessage: true,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "Что бы тебе еще написать",
                    isIncomingMessage: false,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "Остаться вживых",
                    isIncomingMessage: true,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "Полнолуние скоро",
                    isIncomingMessage: false,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "С новым годом",
                    isIncomingMessage: true,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "С днем рождени]",
                    isIncomingMessage: false,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "Когда будем есть",
                    isIncomingMessage: true,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "Где мои носки",
                    isIncomingMessage: false,
                    date: generateRandomDate(daysBack: 5)),


            ConversationCellModel.init(textMessage: "Кота покормила",
                    isIncomingMessage: true,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "Шапку одел",
                    isIncomingMessage: false,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "Спокойной ночи",
                    isIncomingMessage: true,
                    date: generateRandomDate(daysBack: 5)),

            ConversationCellModel.init(textMessage: "Приятного апетита",
                    isIncomingMessage: false,
                    date: generateRandomDate(daysBack: 5)),
        ]
    }

    func generateRandomDate(daysBack: Int) -> Date {
        let day = arc4random_uniform(UInt32(daysBack)) + 1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)

        let today = Date(timeIntervalSinceNow: 0)
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = Int(day - 1)
        offsetComponents.hour = Int(hour)
        offsetComponents.minute = Int(minute)

        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0))
        return randomDate ?? Date()
    }

}

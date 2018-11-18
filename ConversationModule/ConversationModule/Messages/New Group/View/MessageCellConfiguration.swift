//
// Created by Иван Lardis on 06/10/2018.
// Copyright (c) 2018 ivan larin. All rights reserved.
//

import Foundation

protocol MessageCellConfiguration: class {
    var textMessage: String? { get set }
    var date: Date? { get set }
}

//
//  IRequestSender.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

protocol IRequestSender {
    func send<Parser>(config: RequestConfig<Parser>) -> Result<Parser.Model>
}

//
//  RequestConfig.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

struct RequestConfig<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser
}

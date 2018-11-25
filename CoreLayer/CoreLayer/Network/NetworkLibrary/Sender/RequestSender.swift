//
//  RequestSender.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class RequestSender: IRequestSender {
    let session = URLSession.shared

    func send<Parser>(config: RequestConfig<Parser>) -> Result<Parser.Model> where Parser: IParser {

        guard let url = config.request.urlRequest else {
            return Result.error("url string can't be parsed to URL")
        }

        let (data, _, error) = session.synchronousDataTask(with: url)

        if let error = error {
            return Result.error(error.localizedDescription)
        }
        guard let dataNetwork = data,
              let parsedModel: Parser.Model = config.parser.parse(data: dataNetwork) else {
            return Result.error("received data can't be parsed")
        }

        return Result.success(parsedModel)
    }
}

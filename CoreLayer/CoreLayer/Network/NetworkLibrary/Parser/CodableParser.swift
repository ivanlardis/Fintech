//
//  CodableParser.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class CodableParser<CodableModel>: IParser where CodableModel: Codable {
    typealias Model = CodableModel

    func parse(data: Data) -> CodableModel? {
        let decoder = JSONDecoder()
        let model: CodableModel? = try? decoder.decode(CodableModel.self, from: data)
        return model
    }
}

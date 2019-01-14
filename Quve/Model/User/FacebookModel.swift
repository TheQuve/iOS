//
//  FacebookModel.swift
//  Quve
//
//  Created by ParkSungJoon on 14/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Foundation

struct FacebookModel: Codable {
    let token: String?
}

extension FacebookModel {
    enum CodingKeys: String, CodingKey {
        case token
    }
}

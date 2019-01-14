//
//  UserInfoModel.swift
//  Quve
//
//  Created by ParkSungJoon on 14/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Foundation

struct InfoModel: Codable {
    let id: Int?
    let username: String?
}

extension InfoModel {
    enum CodingKeys: String, CodingKey {
        case id, username
    }
}

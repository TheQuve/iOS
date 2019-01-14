//
//  UserLoginModel.swift
//  Quve
//
//  Created by ParkSungJoon on 14/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Foundation

struct LoginModel: Codable {
    let user: InfoModel?
    let token: String?
}

extension LoginModel {
    enum CodingKeys: String, CodingKey {
        case user, token
    }
}

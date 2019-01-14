//
//  UserAPI.swift
//  Quve
//
//  Created by ParkSungJoon on 14/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

enum UserAPI {
    case login(username: String, password: String)
    case facebook(token: String)
    case register(username: String, password: String)
    case info(token: String)
}

extension UserAPI: APIService {
    var subURL: String {
        switch self {
        case .info(let token):
            return "user/info/" + token
        case .login:
            return "user/login/"
        case .facebook:
            return "user/login/facebook/"
        case .register:
            return "user/register"
        }
    }
}

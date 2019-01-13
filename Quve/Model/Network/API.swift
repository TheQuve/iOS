//
//  API.swift
//  Quve
//
//  Created by ParkSungJoon on 13/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

class API {
    static let apiKey = ""
    static let baseUrl = "https://www.thequve.com/api/v1/"
    
    enum Collection {
        case user
        case category
        
        var name: String {
            switch self {
            case .user: return "user"
            case .category: return "category"
            }
        }
    }
    
    enum UserApi {
        case login
        case register
        case info
    }
    
}

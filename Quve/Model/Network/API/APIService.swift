//
//  APIService.swift
//  Quve
//
//  Created by ParkSungJoon on 14/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Alamofire
import Foundation

struct APIService {
    struct ProductionServer {
        static let baseURL = "https://www.thequve.com/api/v1"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

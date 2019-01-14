//
//  APIConfiguration.swift
//  Quve
//
//  Created by ParkSungJoon on 14/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

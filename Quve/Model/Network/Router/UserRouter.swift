//
//  UserAPI.swift
//  Quve
//
//  Created by ParkSungJoon on 14/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Alamofire
import FacebookCore
import FacebookLogin

enum UserRouter {
    case login(username: String, password: String)
    case facebook(accessToken: String)
    case register(username: String, password: String)
    case info(token: String)
}

extension UserRouter: APIConfiguration {
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .facebook:
            return .post
        case .register:
            return .post
        case .info:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/user/login/"
        case .facebook:
            return "/user/facebook/"
        case .register:
            return "/user/register/"
        case .info:
            return "/user/info/"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let username, let password):
            return ["username": username, "password": password]
        case .facebook(let accessToken):
            return ["access_token": accessToken]
        case .register(let username, let password):
            return ["username": username, "password": password]
        case .info:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIService.ProductionServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue

        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}

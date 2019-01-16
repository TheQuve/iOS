//
//  CategoryRouter.swift
//  Quve
//
//  Created by ParkSungJoon on 15/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Alamofire

enum CategoryRouter {
    case categoryList
}

extension CategoryRouter: APIConfiguration {
    
    var method: HTTPMethod {
        switch self {
        case .categoryList:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .categoryList:
            return "/category/category_list/"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .categoryList:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIService.ProductionServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        if let token = UserDefaults.standard.string(forKey: "token") {
            urlRequest.setValue(token, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        
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

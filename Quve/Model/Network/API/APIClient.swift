//
//  APIClient.swift
//  Quve
//
//  Created by ParkSungJoon on 15/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Alamofire

class APIClient {
    
    private static var manager: Alamofire.SessionManager = {
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "www.thequve.com": .disableEvaluation
        ]
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return manager
    }()
    
    static func login(username: String, password: String, completion: @escaping (Result<LoginModel>) -> ()) {
        manager.request(UserRouter.login(username: username, password: password)).responseData { (response) in
            let decoder = JSONDecoder()
            let userData: Result<LoginModel> = decoder.decodeResponse(from: response)
            completion(userData)
        }
    }
}

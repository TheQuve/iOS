//
//  APIClient.swift
//  Quve
//
//  Created by ParkSungJoon on 15/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Alamofire
import FacebookLogin
import FacebookCore

class APIClient {
    
    // SSL 해제
    private static var Manager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "www.thequve.com": .disableEvaluation
        ]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return manager
    }()
    
    // Local Login API
    static func login(username: String, password: String, completion: @escaping (Result<LoginModel>) -> ()) {
        Manager.request(
            UserRouter.login(username: username, password: password))
            .responseData { (response) in
                let decoder = JSONDecoder()
                let userData: Result<LoginModel> = decoder.decodeResponse(from: response)
                completion(userData)
        }
    }
    
    // Facebook Login API
    static func facebook(accessToken: String, completion: @escaping (Result<LoginModel>) -> ()) {
        Manager.request(
            UserRouter.facebook(accessToken: accessToken))
            .responseData { (response) in
                let decoder = JSONDecoder()
                let userData: Result<LoginModel> = decoder.decodeResponse(from: response)
                completion(userData)
        }
    }
    
    // SignUp API
    static func register(username: String, password: String, completion: @escaping (Result<LoginModel>) -> ()) {
        Manager.request(
            UserRouter.register(username: username, password: password))
            .responseData { (response) in
                let decoder = JSONDecoder()
                let userData: Result<LoginModel> = decoder.decodeResponse(from: response)
                completion(userData)
        }
    }
    
    static func getQuestionList(start: Int, limit: Int, completion: @escaping (Result<QuestionModel>) -> ()) {
        Manager.request(
            QuestionRouter.getQuestionList(start: start, limit: limit))
            .responseData { (response) in
                let decoder = JSONDecoder()
                let questionData: Result<QuestionModel> = decoder.decodeResponse(from: response)
                completion(questionData)
        }
    }
    
//    static func question(title: String, contents: String, is_completed: Bool, completion: @escaping (Result<>) -> ()) {
//        
//    }
}

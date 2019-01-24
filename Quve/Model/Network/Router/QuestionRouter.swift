//
//  QuestionRouter.swift
//  Quve
//
//  Created by ParkSungJoon on 15/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//
//
import Alamofire


enum QuestionRouter {
    case getQuestionList(start: Int, limit: Int)
    case question(title: String, category: Int, contents: String, point: Int, limit: Int, user_class: String, region: String, is_open: Bool, is_completed: Bool)
    case getQuestion(question_id: Int)
}

extension QuestionRouter: APIConfiguration {

    var method: HTTPMethod {
        switch self {
        case .getQuestionList:
            return .get
        case .question:
            return .post
        case .getQuestion:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getQuestionList(let start, let limit):
            return "/question/question_list/?start=\(start)&limit=\(limit)"
        case .question:
            return "/question/input_question/"
        case .getQuestion(let question_id):
            return "/question/\(question_id)/"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getQuestionList:
            return nil
        case .question(let title, let category, let contents, let point, let limit, let user_class, let region, let is_open, let is_completed):
            return ["title": title,
                    "category": category,
                    "contents": contents,
                    "point": point,
                    "limit": limit,
                    "user_class": user_class,
                    "region": region,
                    "is_open": is_open,
                    "is_completed": is_completed]
        case .getQuestion:
            return nil
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try (APIService.ProductionServer.baseURL + path).asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        if let token = UserDefaults.standard.string(forKey: "token") {
            urlRequest.setValue("token " + token, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
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

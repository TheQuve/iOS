//
//  QuestionModel.swift
//  Quve
//
//  Created by ParkSungJoon on 16/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Foundation

struct QuestionModel: Codable {
    let title: String?
    let contents: String?
    let isCompleted: Bool?
}

extension QuestionModel {
    enum CodingKeys: String, CodingKey {
        case title, contents
        case isCompleted = "is_completed"
    }
}

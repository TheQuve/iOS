//
//  Questions.swift
//  Quve
//
//  Created by ParkSungJoon on 19/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Foundation

struct Questions: Codable {
    let data: [Question]?
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode([Question].self, forKey: .data)
    }
}
extension Questions {
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct Question: Codable {
    let id: Int?
    let title: String?
    let writer: Writer?
    let category: Category?
    let createdAt: String?
    let updatedAt: String?
    let isCompleted: Bool?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        writer = try container.decode(Writer.self, forKey: .writer)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
        do {
            category = try container.decode(Category.self, forKey: .category)
        } catch {
            category = nil
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, writer, category
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isCompleted = "is_completed"
    }
}

struct Category: Codable {
    let id: Int?
    let contents: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        contents = try container.decode(String.self, forKey: .contents)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, contents
    }
}

struct Writer: Codable {
    let id: Int?
    let username: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, username
    }
}

//
//  PwChangedUser.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/13.
//

import Foundation

struct PwChangedUser: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let blocked: Bool?
    let role: Role2
    let createdAt, updatedAt: String
    let posts: [Post2]
    let comments: [Comment2]

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, blocked, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case posts, comments
    }
}

struct Comment2: Codable {
    let id: Int
    let comment: String
    let user: Int
    let post: Int?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// MARK: - Post
struct Post2: Codable {
    let id: Int
    let text: String
    let user: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// MARK: - Role
struct Role2: Codable {
    let id: Int
    let name, roleDescription, type: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roleDescription = "description"
        case type
    }
}

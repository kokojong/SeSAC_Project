//
//  Model.swift
//  SeSAC_week14
//
//  Created by kokojong on 2021/12/28.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let jwt: String
    let user: User
}

// MARK: - User
struct User: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let blocked: JSONNull?
    let role: Role
    let createdAt, updatedAt: String
    let boards: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, blocked, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case boards
    }
}

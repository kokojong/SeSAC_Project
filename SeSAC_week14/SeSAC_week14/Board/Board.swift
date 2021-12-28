//
//  Board.swift
//  SeSAC_week14
//
//  Created by kokojong on 2021/12/28.
//

import Foundation

struct BoardElement: Codable {
    let id: Int
    let text: String
    let usersPermissionsUser: UsersPermissionsUser
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, text
        case usersPermissionsUser = "users_permissions_user"
        case updatedAt = "updated_at"
    }
}

// MARK: - UsersPermissionsUser
struct UsersPermissionsUser: Codable {
    let id: Int
    let username, email : String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email
        case updatedAt = "updated_at"
    }
}

typealias Board = [BoardElement]

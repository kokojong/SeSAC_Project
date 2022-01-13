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
//    let blocked: JSONNull?
    let role: Role
    let createdAt, updatedAt: String
    let posts: [PostElement]
    let comments: [CommentElement]

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case posts, comments
    }
}

//
//  SignUp.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/02.
//

// MARK: - SignUp
struct SignUp: Codable {
    let jwt: String
    let user: User
}

// MARK: - User
struct User: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
//    let blocked: JSONNull?
    let role: Role
    let createdAt, updatedAt: String
//    let posts, comments: [String] //

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, role
//        case blocked
        case createdAt = "created_at"
        case updatedAt = "updated_at"
//        case posts, comments
    }
}

// MARK: - Role
struct Role: Codable {
    let id: Int
    let name, roleDescription, type: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roleDescription = "description"
        case type
    }
}

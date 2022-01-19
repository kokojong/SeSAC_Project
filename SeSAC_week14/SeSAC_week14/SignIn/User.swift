//
//  User.swift
//  SeSAC_week14
//
//  Created by kokojong on 2021/12/28.
//

import Foundation

// MARK: - Welcome
struct User: Codable {
    let jwt: String
    let user: UserClass
}

// MARK: - User
struct UserClass: Codable {
    let id: Int
    let username, email : String
}

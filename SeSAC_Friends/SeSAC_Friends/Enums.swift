//
//  Enums.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/01.
//

import Foundation

enum GenderCase: Int {
    case man = 1
    case woman = 0
    case unselected = -1
}

enum StatusCodeCase: Int {
    case success = 200
    case invalidNickname = 202
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

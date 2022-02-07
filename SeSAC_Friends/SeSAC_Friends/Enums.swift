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
    case all = 2
}

enum UserStatusCodeCase: Int {
    case success = 200
    case invalidNickname = 202
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum QueueStataCodeCase: Int {
    case success = 200
    case blockedUser = 201
    case cancelPanlty1 = 203
    case cancelPanlty2 = 204
    case cancelPanlty3 = 205
    case invalidGender = 206
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum OnQueueStatusCodeCase: Int {
    case success = 200
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum MyStatusCase: Int {
    case normal = 0
    case matching = 1
    case matched = 2
}

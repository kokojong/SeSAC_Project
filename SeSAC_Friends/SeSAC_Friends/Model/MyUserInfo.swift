//
//  MyUserInfo.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/20.
//

import Foundation

struct MyUserInfo: Codable {
    var id: String
    var v: Int
    var uid, phoneNumber, email: String
    var fcMtoken, nick, birth: String
    var gender: Int
    var hobby: String
    var comment: [String]
    var reputation: [Int]
    var sesac: Int
    var sesacCollection: [Int]
    var background: Int
    var backgroundCollection: [Int]
    var purchaseToken, transactionID, reviewedBefore: [String]
    var reportedNum: Int
    var reportedUser: [String]
    var dodgepenalty: Int
//    let dodgepenaltyGetAt: String
    var dodgeNum: Int
//    let dodgeNumGetAt: String
    var ageMin, ageMax, searchable: Int
    var createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "__v"
        case uid, phoneNumber, email
        case fcMtoken = "FCMtoken"
        case nick, birth, gender, hobby, comment, reputation, sesac, sesacCollection, background, backgroundCollection, purchaseToken
        case transactionID = "transactionId"
        case reviewedBefore, reportedNum, reportedUser, dodgepenalty
//        case dodgepenaltyGetAt = "dodgepenalty_getAt"
        case dodgeNum
//        case dodgeNumGetAt = "dodgeNum_getAt"
        case ageMin, ageMax, searchable, createdAt
    }
}

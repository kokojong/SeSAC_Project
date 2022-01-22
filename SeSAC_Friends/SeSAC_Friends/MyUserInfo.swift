//
//  MyUserInfo.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/20.
//

import Foundation

struct MyUserInfo: Codable {
    let id: String
    let v: Int
    let uid, phoneNumber, email, socketid: String
    let fcMtoken, nick, birth: String
    let gender: Int
    let hobby: String
    let comment: [String]
    let reputation: [Int]
    let sesac: Int
    let sesacCollection: [Int]
    let background: Int
    let backgroundCollection: [Int]
    let purchaseToken, transactionID, reviewedBefore: [String]
    let reportedNum: Int
    let reportedUser: [String]
    let dodgepenalty: Int
    let dodgepenaltyGetAt: String
    let dodgeNum: Int
    let dodgeNumGetAt: String
    let ageMin, ageMax, searchable: Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "__v"
        case uid, phoneNumber, email, socketid
        case fcMtoken = "FCMtoken"
        case nick, birth, gender, hobby, comment, reputation, sesac, sesacCollection, background, backgroundCollection, purchaseToken
        case transactionID = "transactionId"
        case reviewedBefore, reportedNum, reportedUser, dodgepenalty
        case dodgepenaltyGetAt = "dodgepenalty_getAt"
        case dodgeNum
        case dodgeNumGetAt = "dodgeNum_getAt"
        case ageMin, ageMax, searchable, createdAt
    }
}

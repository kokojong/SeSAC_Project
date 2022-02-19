//
//  UpdateMypageFrom.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/01.
//

import Foundation

struct SignUpForm: Encodable {
    let phoneNumber: String
    var FCMtoken: String
    let nick: String
    let email: String
    let birth: Date
    var gender: Int
}

struct OnQueueForm: Encodable {
    let region: Int
    let lat: Double
    let long: Double
}

struct PostQueueForm: Encodable {
    let type: Int
    let region: Int
    let lat: Double
    let long: Double
    let hf: [String]
}

struct UpdateMypageForm: Encodable {
    let searchable: Int
    let ageMin: Int
    let ageMax: Int
    let gender: Int
    let hobby: String
}

struct WriteReviewFrom: Encodable {
    let otheruid: String
    let reputation: [Int]
    let comment: String
}

struct ReportOtherFrom: Encodable {
    let otheruid: String
    let reportedReputation: [Int]
    let comment: String
}

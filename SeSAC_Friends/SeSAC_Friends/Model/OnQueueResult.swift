//
//  OnQueueResult.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/06.
//

import Foundation

struct OnQueueResult: Codable {
    var fromQueueDB: [OtherUserInfo]
    var fromQueueDBRequested: [OtherUserInfo]
    var fromRecommend: [String]
    
    struct OtherUserInfo: Codable {
        let uid: String
        let nick: String
        let lat: Double
        let long: Double
        let reputation: [Int]
        let hf: [String]
        let reviews: [String]
        let gender: Int
        let type: Int
        let sesac: Int
        let background: Int
    }
    
}



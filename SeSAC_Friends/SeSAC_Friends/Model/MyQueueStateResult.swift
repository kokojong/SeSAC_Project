//
//  MyQueueStateResult.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/16.
//

import Foundation

struct MyQueueStateResult: Codable {
    var dodged: Int
    var matched: Int
    var reviewed: Int
    var matchedNick: String
    var matchedUid: String
}


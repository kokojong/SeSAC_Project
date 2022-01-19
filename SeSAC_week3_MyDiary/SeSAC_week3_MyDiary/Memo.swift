//
//  Memo.swift
//  SeSAC_week3_MyDiary
//
//  Created by kokojong on 2021/10/14.
//

import Foundation

enum Category : Int {
    case business = 0, personal, others // 0 1 2
    
    var description : String {
        switch self {
        case .business:
            return "업무"
        case .personal:
            return "개인"
        case .others:
            return "기타"
        }
    }
}

struct Memo {
    var content : String
    var category : Category
}

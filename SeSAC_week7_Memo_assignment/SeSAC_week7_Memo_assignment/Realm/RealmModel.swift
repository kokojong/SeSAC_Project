//
//  RealmModel.swift
//  SeSAC_week7_Memo_assignment
//
//  Created by kokojong on 2021/11/08.
//

import Foundation
import RealmSwift

class Memo: Object{
    @Persisted var memoTitle: String // 메모 제목(필수) -> 빈값이라면 저장 되지 않도록 해주기(추가적으로)
    @Persisted var memoContent: String // 메모 내용(필수) -> 빈값이라면 "" 으로 저장
    @Persisted var memoDate: Date // 메모 생성 일자(필수) -> 최신순 정렬
    @Persisted var isPinned: Bool // 고정되었는지 여부

    // PK(필수): Int, String, UUID, objectID 등 -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
      
    // 초기화
    convenience init(memoTitle: String, memoContent: String, memoDate: Date) {
        self.init()
        
        self.memoTitle = memoTitle
        self.memoContent = memoContent
        self.memoDate = memoDate
        self.isPinned = false // 처음에는 false로 초기화
        
    }
    
}


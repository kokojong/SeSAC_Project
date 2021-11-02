//
//  RealmModel.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/02.
//

import Foundation
import RealmSwift


// UserDiary: 테이블의 이름
// @Persisted: 컬럼의 이름
class UserDiary: Object {
    @Persisted var diaryTitle: String // 제목(필수)
    @Persisted var diaryContent: String? // 내용(옵션)
    @Persisted var diaryDate =  Date() // 작성날짜(필수)
    @Persisted var diaryRegisterDate =  Date() // 등록날짜(필수)
    @Persisted var bookmark: Bool // 즐겨찾기(필수)

    
    // PK(필수): Int, String, UUID, objectID 등 -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
      
    // 초기화
    convenience init(diaryTitle: String, diaryContent: String?, diaryDate: Date, diaryRegisterDate: Date) {
        self.init()
    
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryContent
        self.diaryDate = diaryDate
        self.diaryRegisterDate = diaryRegisterDate
        self.bookmark = false
        
    }
}


//
//  RealModel.swift
//  SeSAC_week6_ShoppingList
//
//  Created by kokojong on 2021/11/02.
//

import Foundation
import RealmSwift

class ShoppingList: Object {
    @Persisted var itemName: String // 아이템의 이름(필수)
    @Persisted var check: Int // 체크 여부(필수) 기본값은 0 - false
    @Persisted var bookmark: Int // 북마크 여부(필수) 기본값은 0 - false

    // PK(필수): Int, String, UUID, objectID 등 -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
      
    // 초기화
    convenience init(itemName: String) {
        self.init()
        
        self.itemName = itemName
        self.check = 0 // 처음에는 둘다 0으로 초기화 해버림(만들때라서)
        self.bookmark = 0
    
    }
}

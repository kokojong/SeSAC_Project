//
//  RealmModel.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/11/02.
//

import Foundation
import RealmSwift

class BoxOfficeList: Object {
    @Persisted var dateString: String // 날짜를 스트링으로 받아옴
    @Persisted var titleList: List<String> // 영화 제목 리스트
//    @Persisted var rankList: List<Int> // 영화 순위 리스트
    @Persisted var releaseDateList: List<String> // 영화 개봉일 리스트
    
    var titleArray: [String] {
            get {
                return titleList.map{$0}
            }
            set {
                titleList.removeAll()
                titleList.append(objectsIn: newValue)
            }
        }
    
    var releaseDateArrary: [String] {
        get {
            return releaseDateList.map{$0}
        }
        set {
            releaseDateList.removeAll()
            releaseDateList.append(objectsIn: newValue)
        }
    }

    // PK(필수): Int, String, UUID, objectID 등 -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
      
    // 초기화
    convenience init(dateString: String, titleArray: [String], releaseDateArray: [String]) {
        // (dateString: String, titleList: List<String>, releaseDateList: List<String>)
        self.init()
        
        self.dateString = dateString
        self.titleList = titleList
        self.releaseDateList = releaseDateList

        self.titleArray = titleArray
        self.releaseDateArrary = releaseDateArray
        
    }
}

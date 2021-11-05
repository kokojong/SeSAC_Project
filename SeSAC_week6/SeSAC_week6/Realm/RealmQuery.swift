//
//  RealmQuery.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/05.
//

import Foundation
import UIKit
import RealmSwift

extension UIViewController {
    
    func searchQueryFromUserDiary(text: String) -> Results<UserDiary> {
        
        let localRealm = try! Realm()
        
        let search = localRealm.objects(UserDiary.self).filter("diaryTitle == CONTAINS[c] '\(text)' OR diaryContent == CONTAINS[c] '\(text)'")
              
        return search
        
    }
    
    func getAlldiaryCount() -> Int {
        let localRealm = try! Realm()
        
        return localRealm.objects(UserDiary.self).count
    }
    
}

//
//  String+Extension.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import Foundation

extension String {
//    var localized: String {
//        get {
//            return NSLocalizedString(self, comment: "")
//
//        }
//    }
    
    func localized(tableName: String = "Localizable") -> String {
        // 디폴트로는 Localizable을 테이블 네임으로 가진다.
        return NSLocalizedString(self, tableName: tableName, bundle: .main, value: "", comment: "")
    }
}

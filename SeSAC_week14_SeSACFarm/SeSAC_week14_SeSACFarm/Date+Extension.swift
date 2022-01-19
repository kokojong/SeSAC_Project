//
//  Date+Extension.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/13.
//

import Foundation

extension String {
    var toDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "ko-KR")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        // 2021-01-01T12:00:41.000Z
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = formatter.date(from: self) ?? Date()
        return date.toString
    }
}

extension Date {
    var toString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "ko-KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: self)
    }
}

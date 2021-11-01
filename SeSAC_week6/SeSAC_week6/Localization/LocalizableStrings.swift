//
//  LocalizableStrings.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import Foundation

enum LocalizableStrings: String {
    case welcomeText = "kokojong"
    case settingText = "Setting"
    case homeText = ""
    
    
    var localized: String {
        return self.rawValue.localized() // 기본값이므로Localizable.strings
    }
    
    var localizedSetting: String {
        return self.rawValue.localized(tableName: "Setting") // 문자열을 입력으로 받는경우 -> 그대로 출력
    }
    
    
}

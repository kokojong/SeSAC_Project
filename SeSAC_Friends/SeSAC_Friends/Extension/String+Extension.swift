//
//  UITextField+Extension.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/19.
//

import UIKit

extension String {
    func pretty() -> String {
        let _str = self.replacingOccurrences(of: "-", with: "")
        let arr = Array(_str)
        if arr.count > 3 {
            let prefix = String(format: "%@%@", String(arr[0]), String(arr[1]))
            if prefix == "02" {
                if let regex = try? NSRegularExpression(pattern: "([0-9]{2})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                    return modString
                    
                }
                
            } else if prefix == "15" || prefix == "16" || prefix == "18" {
                if let regex = try? NSRegularExpression(pattern: "([0-9]{4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2")
                    return modString
                    
                }
                
            } else {
                if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                    return modString
                    
                }
                
            }
            
        }
        return self
        
    }
    
}

extension String {
    
    func toPhoneNumberPattern(pattern: String, replacmentCharacter: Character) -> String {
        
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        
        for index in 0 ..< pattern.count {
            
            guard index < pureNumber.count else { return pureNumber }

            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            
            guard patternCharacter != replacmentCharacter else { continue }
            
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}

extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1) //
        
        return String(self[startIndex ..< endIndex])
    }
}


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
        
        formatter.dateFormat = "a HH:mm"
        return formatter.string(from: self)
    }
}

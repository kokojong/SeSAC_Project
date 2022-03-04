//
//  Validator.swift
//  SeSAC_week23_Test
//
//  Created by kokojong on 2022/03/02.
//

import Foundation

final class Validator {
    
    func isValidID(id: String) -> Bool {
//        guard let id = idTextField.text else { return false }
                
        return id.count >= 6 && id.contains("@")
    }
    
    func isValidPW(pw: String) -> Bool {
//        guard let pw = pwTextField.text else { return false }
        
        return pw.count >= 6 && pw.count < 10
    }
    
    func isEqualPW(pw: String, check: String) -> Bool {
//        guard let pw = pwTextField.text, let check = checkTextField.text else { return false }
        
        return pw == check
    }
    
}

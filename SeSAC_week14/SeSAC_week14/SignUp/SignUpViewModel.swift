//
//  SignUpViewModel.swift
//  SeSAC_week14
//
//  Created by kokojong on 2021/12/28.
//

import Foundation

class SignUpViewModel {
    
    var username: Observable<String> = Observable("")
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    func postUserRegister(completion: @escaping () -> Void) {
        APIService.register(username: username.value, email: email.value, password: password.value) { userData, error in
            print("userData",userData)
            print("error",error)
            guard let userData = userData else {
                return
            }
            
            
            completion()

        }
    }
    
    func saveUserInfo() {
//        username.
    }
    
    
}

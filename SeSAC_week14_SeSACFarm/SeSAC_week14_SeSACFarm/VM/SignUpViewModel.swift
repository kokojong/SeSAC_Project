//
//  SignUpViewModel.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/02.
//

import Foundation

class SignUpViewModel {
    
    var username: Observable<String> = Observable("")
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    var signUp: Observable<User> = Observable(User(jwt: "", user: UserInfo(id: 0, username: "", email: "", provider: "", confirmed: true, role: Role(id: 0, name: "", roleDescription: "", type: ""), createdAt: "", updatedAt: "")))
    
    func postSignUp(completion: @escaping () -> Void) {
        APIService.signUp(username: username.value, email: email.value, password: password.value) { signup, error in
//            print("signup",signup)
//            print("error",error)
            
            guard let signup = signup else {
                return
            }
            self.signUp.value = signup
            
            completion()
        }
        
    }
}

//
//  SignInViewModel.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/02.
//

import Foundation

class SignInViewModel {
    
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var signIn: Observable<User> = Observable(User(jwt: "", user: UserInfo(id: 0, username: "", email: "", provider: "", confirmed: true, role: Role(id: 0, name: "", roleDescription: "", type: ""), createdAt: "", updatedAt: "")))
    
    func postSignIn(completion: @escaping () -> Void) {
        APIService.signIn(identifier: email.value, password: password.value) { signin, error in
//            print("signin",signin)
//            print("error",error)
//            
            guard let signin = signin else {
                return
            }

            self.signIn.value = signin
            
            UserDefaults.standard.set(signin.jwt, forKey: "token")
//            print(UserDefaults.standard.string(forKey: "token"))
            
            completion()
        }
        
    }
    
}

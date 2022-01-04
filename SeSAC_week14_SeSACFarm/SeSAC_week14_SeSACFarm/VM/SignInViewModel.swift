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
    
    func postSignIn(completion: @escaping (APIError?) -> Void) {
        APIService.signIn(identifier: email.value, password: password.value) { signin, error in
            print("signin",signin)
            print("error",error)

            // 401 에러(토큰 유효기간 만료)
            if let error = error {
                if error == .unauthorized {
                    print("unauthorized")
                    UserDefaults.standard.set("", forKey: "token")
                } else {
                    print("error is \(error)")
                }
            }
            
            if let error2 = error {
                print("error2",error2)
                completion(error2)
                return
            }

            
            guard let signin = signin else {
                return
            }

            self.signIn.value = signin
            
            UserDefaults.standard.set(signin.jwt, forKey: "token")
//            print(UserDefaults.standard.string(forKey: "token"))
            
            
            completion(nil) // error 없는거
        }
        
    }
    
}

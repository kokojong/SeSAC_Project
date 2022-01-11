//
//  SignInViewModel.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/02.
//

import Foundation
import UIKit

class SignInViewModel {
    
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var signIn: Observable<User> = Observable(User(jwt: "", user: UserInfo(id: 0, username: "", email: "", provider: "", confirmed: true, role: Role(id: 0, name: "", roleDescription: "", type: ""), createdAt: "", updatedAt: "")))
    
    func postSignIn(completion: @escaping (APIError?) -> Void) {
        APIService.signIn(identifier: email.value, password: password.value) { signin, error in

            // 401 에러(토큰 유효기간 만료)
            if let error = error {
                if error == .unauthorized {
                    print("unauthorized")
                    UserDefaults.standard.set("", forKey: "token")
                    UserDefaults.standard.set(0, forKey: "userId")
                    
                    DispatchQueue.main.async {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: SignInViewController())
                        windowScene.windows.first?.makeKeyAndVisible()
                    }

                    
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
            UserDefaults.standard.set(signin.user.id, forKey: "userId")
            
            completion(nil) // error 없는거
        }
        
    }
    
}

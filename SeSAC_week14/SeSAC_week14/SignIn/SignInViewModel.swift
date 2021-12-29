//
//  SignInViewModel.swift
//  SeSAC_week14
//
//  Created by kokojong on 2021/12/28.
//

import Foundation
 
class SignInViewModel {
    
    var username: Observable<String> = Observable("임의임의")
    
    var password: Observable<String> = Observable("")
    
    func postUserLogin(completion: @escaping () -> Void) {
        APIService.login(identifier: username.value, password: password.value) { userData, error in
            print("userData",userData)
            print("error",error)
            
            guard let userData = userData else {
                return
            }

            // 로그인 성공 -> 토큰을 저장(유저 디폴트)
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "username")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            // 로그인에 진입하면 root를 새롭게 바꿔줘야 함
//            DispatchQueue.main.async {
//                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
//                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
//                windowScene.windows.first?.makeKeyAndVisible()
//            }
            completion()
            
            
        }
    }
    
    func getUsername() {
        username.value = UserDefaults.standard.string(forKey: "username") ?? ""
    }
    
    
    
}

//
//  ViewController.swift
//  SeSAC_week14
//
//  Created by kokojong on 2021/12/28.
//

import UIKit

class SignInViewController: UIViewController {
    
    let mainView = SignInView()
    
    let viewModel = SignInViewModel()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 로그인 했던 기록이 있다면 바로 Board로 가도록처리
        
        if let logined = UserDefaults.standard.string(forKey: "token") {
          DispatchQueue.main.async {
              guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
              windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: BoardViewController())
              windowScene.windows.first?.makeKeyAndVisible()
          }
        }
        
        view.backgroundColor = .white
        
        print("value : ",viewModel.username.value)
//        viewModel.username.value = "asd"
        viewModel.username.bind { text in
            print("bind username text : ",text)
            self.mainView.usernameTextField.text = text
        }
        
        viewModel.password.bind { text in
            self.mainView.passwordTextField.text = text
        }
        
        mainView.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        
        
        mainView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        mainView.goToSignUpButton.addTarget(self, action: #selector(goToSignUpButtonClicked), for: .touchUpInside)
        
        
    }
    
    @objc func usernameTextFieldDidChange(_ textField: UITextField) {
        viewModel.username.value = textField.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        viewModel.password.value = textField.text ?? ""
    }

    @objc func signInButtonClicked() {
        
        viewModel.postUserLogin {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: BoardViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }

        }
        // MVVM으로 바꿔봄
//        APIService.login(identifier: mainView.usernameTextField.text!, password: mainView.passwordTextField.text!) { userData, error in
//            
//            guard let userData = userData else {
//                return
//            }
//
//            // 로그인 성공 -> 토큰을 저장(유저 디폴트)
//            UserDefaults.standard.set(userData.jwt, forKey: "token")
//            UserDefaults.standard.set(userData.user.username, forKey: "username")
//            UserDefaults.standard.set(userData.user.id, forKey: "id")
//            UserDefaults.standard.set(userData.user.email, forKey: "email")
//            
//            // 로그인에 진입하면 root를 새롭게 바꿔줘야 함
//            DispatchQueue.main.async {
//                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
//                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
//                windowScene.windows.first?.makeKeyAndVisible()
//            }
//            
//            
//        }
    
    }
    
    @objc func goToSignUpButtonClicked() {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
        
    }
}

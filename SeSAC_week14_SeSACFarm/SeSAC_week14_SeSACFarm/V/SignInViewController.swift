//
//  SignInViewController.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/02.
//

import UIKit

class SignInViewController: UIViewController {
    
    let signInView = SignInView()
    
    var viewModel = SignInViewModel()
    
    override func loadView() {
        self.view = signInView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.email.bind { text in
            self.signInView.emailTextField.text = text
        }
        
        viewModel.password.bind { text in
            self.signInView.passwordTextField.text = text
        }

        
        signInView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        signInView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        signInView.signInButton.addTarget(self, action: #selector(onSignInButtonClicked), for: .touchUpInside)
    }
    
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        viewModel.email.value = textField.text ?? ""
    }

    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        viewModel.password.value = textField.text ?? ""
    }

    @objc func onSignInButtonClicked() {
        viewModel.postSignIn { error in
            
            if let loginError = error {
                print("로그인 에러 : \(loginError)")
                self.view.makeToast("로그인 실패")
            } else {
                self.view.makeToast("로그인 완료")
                print("token : ", self.viewModel.signIn.value.jwt)
                // 일단은 push로 하고 추후에 rootview를 바꿔주는거로 바꾸기
                self.navigationController?.pushViewController(PostMainViewController(), animated: true)
            }
            
        }
      
    }
}

//
//  SignUpViewController.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/02.
//

import UIKit
import Toast

class SignUpViewController: UIViewController {
    
    let signUpView = SignUpView()
    
    var viewModel = SignUpViewModel()
    
    override func loadView() {
        self.view = signUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.username.bind { text in
            print("bind:",text)
            self.signUpView.nicknameTextField.text = text
        }
        viewModel.email.bind { text in
            self.signUpView.emailTextField.text = text
        }
        viewModel.password.bind { text in
            self.signUpView.passwordTextField.text = text
        }
        
        signUpView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange(_:)), for: .editingChanged)
        signUpView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        signUpView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        signUpView.signUpButton.addTarget(self, action: #selector(onSignUpButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func nicknameTextFieldDidChange(_ textField: UITextField) {
        viewModel.username.value = textField.text ?? ""
    }
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        viewModel.email.value = textField.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        viewModel.password.value = textField.text ?? ""
    }
    
    @objc func onSignUpButtonClicked() {
        if signUpView.passwordTextField.text == signUpView.passwordCheckTextField.text {
            viewModel.postSignUp {
                self.view.makeToast("회원가입이 완료 되었습니다")
            }
        } else {
            signUpView.makeToast("비밀번호가 다릅니다")
        }
    }
}

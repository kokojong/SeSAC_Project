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
            viewModel.postSignUp { error in
                
                if let error = error {
                    var erroMessage = ""
                    
                    switch error {
                    case .invalidResponse:
                        erroMessage = "유효하지 않은 접근입니다"
                    case .noData:
                        erroMessage = "데이터가 없습니다"
                    case .failed:
                        erroMessage = "이미 존재하는 이메일 또는 닉네임입니다" // 이메일 형식은 Rx로 해보기
                    case .invalidData:
                        erroMessage = "유효하지 않은 데이터입니다"
                    case .unauthorized:
                        erroMessage = "로그인 토큰이 만료되었습니다"
                    }
                    
                    self.view.makeToast("\(erroMessage)")

                }
                
                self.view.makeToast("회원가입이 완료되었습니다")
                sleep(UInt32(0.5))
                self.navigationController?.pushViewController(SignInViewController(), animated: true)
                
            }
        } else {
            signUpView.makeToast("비밀번호가 다릅니다")
        }
    }
    // MARK: 유효성 검사
    func checkValidation() -> Bool {
        return false
    }
}

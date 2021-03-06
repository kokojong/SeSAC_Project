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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func loadView() {
        self.view = signUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        signUpView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        signUpView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange(_:)), for: .editingChanged)
        signUpView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        signUpView.signUpButton.addTarget(self, action: #selector(onSignUpButtonClicked), for: .touchUpInside)
        
        signUpView.emailTextField.delegate = self
        signUpView.nicknameTextField.delegate = self
        signUpView.passwordTextField.delegate = self
        signUpView.passwordCheckTextField.delegate = self
        
        
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
        
        let emailValidation = checkEmailValidation()
        
        if emailValidation {
            if signUpView.passwordTextField.text == signUpView.passwordCheckTextField.text {
                viewModel.postSignUp { error in
                    
                    if let error = error {
                        var erroMessage = ""
                        
                        switch error {
                        case .invalidResponse:
                            erroMessage = "???????????? ?????? ???????????????"
                        case .noData:
                            erroMessage = "???????????? ????????????"
                        case .failed:
                            erroMessage = "?????? ???????????? ????????? ?????? ??????????????????" // ????????? ????????? Rx??? ?????????
                        case .invalidData:
                            erroMessage = "???????????? ?????? ??????????????????"
                        case .unauthorized:
                            erroMessage = "????????? ????????? ?????????????????????"
                        }
                        
                        self.view.makeToast("\(erroMessage)")

                    }
                    
                    self.view.makeToast("??????????????? ?????????????????????")
                    sleep(UInt32(0.5))
                    self.navigationController?.pushViewController(SignInViewController(), animated: true)
                    
                }
            } else {
                signUpView.makeToast("??????????????? ????????????")
            }
            
        } else {
            signUpView.makeToast("????????? ????????? ???????????????")
        }
        
        
      
    }
    // MARK: ????????? ??????
    func checkEmailValidation() -> Bool {
        if (signUpView.emailTextField.text!.contains("@")) && signUpView.emailTextField.text!.contains(".") {
            return true
        } else {
            return false
        }
        
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.signUpView.emailTextField {
            self.signUpView.nicknameTextField.becomeFirstResponder()
        } else if textField == self.signUpView.nicknameTextField {
            self.signUpView.passwordTextField.becomeFirstResponder()
        } else if textField == self.signUpView.passwordTextField {
            self.signUpView.passwordCheckTextField.becomeFirstResponder()
        } else {
            self.signUpView.passwordCheckTextField.resignFirstResponder()
        }
        
        return true
    }
}

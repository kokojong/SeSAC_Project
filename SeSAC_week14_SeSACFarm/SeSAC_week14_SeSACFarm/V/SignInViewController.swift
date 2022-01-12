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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func loadView() {
        self.view = signInView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let newUserEmail = UserDefaults.standard.string(forKey: "newUserEmail")
        if newUserEmail != "" {
            signInView.emailTextField.text = newUserEmail
            viewModel.email.value = newUserEmail ?? ""
        }
        
        signInView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        signInView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        signInView.signInButton.addTarget(self, action: #selector(onSignInButtonClicked), for: .touchUpInside)
        
        signInView.emailTextField.delegate = self
        signInView.passwordTextField.delegate = self
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
                sleep(UInt32(0.5))
                print("token : ", self.viewModel.signIn.value.jwt)

                
                DispatchQueue.main.async {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: PostMainViewController())
                    windowScene.windows.first?.makeKeyAndVisible()
                }
                
            }
            
        }
      
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == signInView.emailTextField {
            signInView.passwordTextField.isFirstResponder
        } else {
            signInView.passwordTextField.resignFirstResponder()
        }
        
        return true
    }
}

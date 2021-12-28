//
//  SignUpViewController.swift
//  SeSAC_week14
//
//  Created by kokojong on 2021/12/28.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let mainView = SignUpView()
    
    let viewModel = SignUpViewModel()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        
        viewModel.username.bind { text in
            self.mainView.usernameTextField.text = text
        }
        viewModel.email.bind { text in
            self.mainView.emailTextField.text = text
        }
        viewModel.password.bind { text in
            self.mainView.passwordTextField.text = text
        }
        
        mainView.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
    }
    
    @objc func usernameTextFieldDidChange(_ textField: UITextField) {
        viewModel.username.value = textField.text ?? ""
    }
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        viewModel.email.value = textField.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        viewModel.password.value = textField.text ?? ""
    }
    
    @objc func signUpButtonClicked() {
        viewModel.postUserRegister {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
            
        }
        
    }




}

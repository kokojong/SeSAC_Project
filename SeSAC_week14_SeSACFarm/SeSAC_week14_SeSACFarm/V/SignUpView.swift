//
//  SignUpView.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/02.
//

import UIKit

class SignUpView: UIView {
    
    let emailTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "이메일"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.addLeftPadding()
        return textField
    }()

    let nicknameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "닉네임"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.addLeftPadding()
        return textField
    }()
    
    let passwordTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.addLeftPadding()
        return textField
    }()
    
    let passwordCheckTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "비밀번호 확인"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.addLeftPadding()
        return textField
    }()
    
    let signUpButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("회원가입", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(emailTextField)
        addSubview(nicknameTextField)
        addSubview(passwordTextField)
        addSubview(passwordCheckTextField)
        addSubview(signUpButton)
    }
    
    func setupConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
        
        passwordCheckTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
        
    }
    
    
    
}

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}

//
//  SignIn.swift
//  SeSAC_week14
//
//  Created by kokojong on 2021/12/28.
//

import UIKit
import SnapKit

protocol ViewRepresentable {
    func setupView()
    func setupConstraints()
    
}

class SignInView: UIView, ViewRepresentable {

    let usernameTextField = UITextField()
    let usernameLabel = UILabel()
    
    let passwordTextField = UITextField()
    let signInButton = UIButton()
    let goToSignUpButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(usernameTextField)
        usernameTextField.backgroundColor = .yellow
        addSubview(usernameLabel)
        usernameLabel.backgroundColor = .red
        
        addSubview(passwordTextField)
        passwordTextField.backgroundColor = .orange
        
        addSubview(signInButton)
        signInButton.setTitle("로그인", for: .normal)
        signInButton.backgroundColor = .blue
        
        addSubview(goToSignUpButton)
        goToSignUpButton.setTitle("회원가입", for: .normal)
        goToSignUpButton.backgroundColor = .magenta
        
    }
    
    func setupConstraints() {
        usernameTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        goToSignUpButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(goToSignUpButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
    }
    
}

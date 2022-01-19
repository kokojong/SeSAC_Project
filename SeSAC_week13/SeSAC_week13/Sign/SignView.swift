//
//  SignView.swift
//  SeSAC_week13
//
//  Created by kokojong on 2021/12/22.
//

import UIKit

class SignView: UIView {
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(){
        emailTextField.backgroundColor = .yellow
        passwordTextField.backgroundColor = .green
        signButton.backgroundColor = .blue
    }
    
    func setConstraints() {
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(signButton)
        
        emailTextField.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints{
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.equalTo(emailTextField.snp.leading)
            $0.leading.equalTo(emailTextField.snp.trailing)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
        
        signButton.snp.makeConstraints{
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.equalTo(emailTextField.snp.leading)
            $0.leading.equalTo(emailTextField.snp.trailing)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
    }
}

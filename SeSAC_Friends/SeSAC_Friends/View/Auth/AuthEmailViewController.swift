//
//  AuthEmailViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/21.
//

import UIKit
import SnapKit
import Toast

class AuthEmailViewController: UIViewController {
    
    let mainView = AuthCommonView()
    
    let subLabel = MainLabel()
    
    var viewModel = AuthViewModel.shared

    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        monitorNetwork()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitorNetwork()

        view.backgroundColor = .white
        
        mainView.mainButton.addTarget(self, action: #selector(onRequestButtonClicked), for: .touchUpInside)
        mainView.mainTextField.addTarget(self, action: #selector(onEmailTextFieldChanged), for: .editingChanged)
        
        addViews()
        addConstraints()
        configViews()
        
        viewModel.email.bind { email in
            self.mainView.mainTextField.text = email
        }
        
        viewModel.isValidEmail.bind { valid in
            if valid {
                self.mainView.mainButton.style = .fill
            } else {
                self.mainView.mainButton.style = .disable
            }
        }
        
    }
    func addViews() {
        self.view.addSubview(subLabel)
    }
    
    func addConstraints() {
        subLabel.snp.makeConstraints { make in
            make.centerX.equalTo(mainView.mainLabel)
            make.top.equalTo(mainView.mainLabel.snp.bottom).offset(8)
        }
    }
    
    
    func configViews() {
        mainView.mainLabel.text = "이메일을 입력해주세요"
        mainView.mainTextField.placeholder = "SeSAC@email.com"
        mainView.mainTextField.becomeFirstResponder()
        mainView.mainButton.setTitle("다음", for: .normal)
        
        
        subLabel.font = .Title2_R16
        subLabel.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
        subLabel.textColor = .gray7
        
        
    }
    
    @objc func onRequestButtonClicked() {
        if viewModel.isValidEmail.value {
            let vc = AuthGenderViewController()
            vc.viewModel = self.viewModel
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            view.makeToast("이메일 형식이 올바르지 않습니다")
        }
        
    }
   
    @objc func onEmailTextFieldChanged() {
        viewModel.email.value = mainView.mainTextField.text ?? ""
        viewModel.checkValidEmail(email: viewModel.email.value)
    }
}

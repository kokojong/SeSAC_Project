//
//  AuthNicknameViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/19.
//

import UIKit
import SnapKit
import Toast

class AuthNicknameViewController: UIViewController {

    let mainView = AuthCommonView()
    
    var viewModel: AuthViewModel!
    
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
        mainView.mainTextField.addTarget(self, action: #selector(onNicknameTextFieldChanged), for: .editingChanged)
        mainView.mainTextField.becomeFirstResponder()
        
        configViews()
        
        viewModel.nickname.bind { nick in
            self.mainView.mainTextField.text = nick
        }
        
        viewModel.isValidNickname.bind { valid in
            if valid {
                self.mainView.mainButton.style = .fill
            } else {
                self.mainView.mainButton.style = .disable
            }
        }
    }
    

    func configViews() {
        mainView.mainLabel.text = "닉네임을 입력해주세요"
        mainView.mainTextField.placeholder = "10자 이내"
        mainView.mainButton.setTitle("다음", for: .normal)
    }
    
    
    @objc func onRequestButtonClicked() {
        
        if self.viewModel.isValidNickname.value {
            let vc = AuthBirthViewController()
            vc.viewModel = self.viewModel
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            view.makeToast("닉네임은 1자 이상 10자 이내로 작성해주세요")
        }
        
        
    }
    
    @objc func onNicknameTextFieldChanged() {
        
        viewModel.nickname.value = mainView.mainTextField.text ?? ""
        viewModel.checkValidNickname(nickname: viewModel.nickname.value)
        
    }


}

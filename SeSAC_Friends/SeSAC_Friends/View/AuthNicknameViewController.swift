//
//  AuthNicknameViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/19.
//

import UIKit
import SnapKit

class AuthNicknameViewController: UIViewController {

    let mainView = AuthCommonView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        mainView.mainButton.addTarget(self, action: #selector(onRequestButtonClicked), for: .touchUpInside)
    
        configViews()
    }
    

    func configViews() {
        mainView.mainLabel.text = "닉네임을 입력해주세요"
        mainView.mainTextField.placeholder = "10자 이내로 입력"
        mainView.mainButton.setTitle("다음", for: .normal)
    }
    
    
    @objc func onRequestButtonClicked() {
        self.navigationController?.pushViewController(AuthBirthViewController(), animated: true)
    }


}

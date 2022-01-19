//
//  AuthBirthViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/19.
//

import UIKit
import SnapKit

class AuthBirthViewController: UIViewController {

    let mainView = AuthCommonView()
    
    let birthPicker = UIDatePicker()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        mainView.mainButton.addTarget(self, action: #selector(onRequestButtonClicked), for: .touchUpInside)
    
        configViews()
        addViews()
        addConstraints()
    }
    

    func configViews() {
        mainView.mainLabel.text = "닉네임을 입력해주세요"
        mainView.mainTextField.isHidden = true
        mainView.seperator.isHidden = true
        mainView.mainButton.setTitle("다음", for: .normal)
        birthPicker.preferredDatePickerStyle = .wheels
        
        
    }
    
    func addViews() {
        self.view.addSubview(birthPicker)
       
    }
    
    func addConstraints() {
        birthPicker.snp.makeConstraints { make in
            make.top.equalTo(self.mainView.mainTextField.snp.top)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
//            make.bottom.equalTo(self.mainView.mainTextField.snp.bottom)
        }
    
    }
    
    @objc func onRequestButtonClicked() {
        self.navigationController?.pushViewController(AuthCheckViewController(), animated: true)
    }

}

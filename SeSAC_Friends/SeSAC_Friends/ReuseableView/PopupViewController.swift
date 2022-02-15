//
//  PopupViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/15.
//

import UIKit
import SnapKit

class PopupViewController: UIViewController, UiViewProtocol {
    
    var otheruid = ""
    
    var isRequest = true
    
    var viewModel = HomeViewModel.shared
    
    let mainView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .white
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .Body1_M16
        $0.textAlignment = .center
    }
    
    let subtitleLabel = UILabel().then {
        $0.textColor = .gray7
        $0.font = .Title4_R14
        $0.textAlignment = .center
    }
    
    let buttonStackView = UIStackView().then {
        $0.spacing = 8
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    let cancelButton = MainButton(type: .cancel).then {
        $0.setTitle("취소", for: .normal)
    }
    
    let okButton = MainButton(type: .fill).then {
        $0.setTitle("확인", for: .normal)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black?.withAlphaComponent(0.5)
        addViews()
        addConstraints()
        
        cancelButton.addTarget(self, action: #selector(onCancelButtonClicked), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(onOkButtonClicked), for: .touchUpInside)
        
        otheruid = UserDefaults.standard.string(forKey: UserDefaultKeys.otherUid.rawValue) ?? ""
        print(otheruid)
    }
    
    func addViews() {
        view.addSubview(mainView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(okButton)
    }
    
    func addConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.top).inset(16)
            make.leading.trailing.equalTo(mainView).inset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(mainView).inset(16)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(mainView).inset(16)
            make.bottom.equalTo(mainView.snp.bottom).inset(16)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        okButton.snp.makeConstraints { make in

            make.height.equalTo(48)
        }
    }
    
    @objc func onCancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onOkButtonClicked() {
        
        if isRequest {
            viewModel.hobbyRequest(otheruid: otheruid) { statuscode, error in
                
                guard let statuscode = statuscode else {
                    return
                }
                
                self.view.makeToast("\(statuscode)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.dismiss(animated: true)
                }
            }
        } else {
            viewModel.hobbyAccept(otheruid: otheruid) { statuscode, error in
                
                guard let statuscode = statuscode else {
                    return
                }
                
                self.view.makeToast("\(statuscode)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
}

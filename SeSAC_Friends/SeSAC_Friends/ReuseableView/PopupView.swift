//
//  PopupView.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/17.
//

import UIKit
import SnapKit
import Then

class PopupView: UIView, UiViewProtocol {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addViews()
        addConstraints()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(mainView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(okButton)
    }
    
    func addConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
//            make.top.bottom.equalToSuperview().inset(100)
//            make.height.equalTo(500)
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
    
    
}

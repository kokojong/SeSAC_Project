//
//  AuthCommonView.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/18.
//

import UIKit

class AuthCommonView: UIView {
    
    let mainLabel : MainLabel = {
       let label = MainLabel()
        label.font = .Display1_R20
        return label
    }()
    
    let mainTextField = MainTextField()
    
    var mainButton = MainButton(type: .disable)
    
    let seperator =  MainSeperator()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(mainButton)
        addSubview(mainLabel)
        addSubview(mainTextField)
        addSubview(seperator)
        addSubview(seperator)
    }
    
    func addConstraints() {
        
        mainButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        mainTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self).inset(16)
            make.bottom.equalTo(mainButton.snp.top).inset(-30)
            make.height.equalTo(48)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.bottom.equalTo(mainTextField.snp.top).inset(-80)
            make.leading.trailing.equalToSuperview().inset(16)
            
        }
        
        seperator.snp.makeConstraints { make in
            make.top.equalTo(mainTextField.snp.bottom)
            make.leading.trailing.equalTo(mainTextField)
            make.height.equalTo(1)
            
        }
        
        
        
    }
}

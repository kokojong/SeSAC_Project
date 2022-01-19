//
//  AuthCommonView.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/18.
//

import UIKit

class AuthCommonView: UIView {
    
    let mainLabel = Display1Label()
    
    let mainTextField = MainTextField()
    
    var mainButton = MainButton(type: .disable)
    
    let seperator: UIView = {
       let view = UIView()
        view.backgroundColor = .gray3
        
        return view
    }()

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
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        
        mainTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(mainButton.snp.top).inset(-72)
            make.height.equalTo(48)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.bottom.equalTo(mainTextField.snp.top).inset(-64)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            
        }
        
        seperator.snp.makeConstraints { make in
            make.top.equalTo(mainTextField.snp.bottom).inset(12)
            make.leading.trailing.equalTo(mainTextField)
            make.height.equalTo(1)
            
        }
        
        
        
    }
}

//
//  BirthTextField.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/23.
//

import UIKit
import SnapKit

class BirthView: UIView {
    
    let textField = MainTextField()
    
    let seperator = MainSeperator()
    
    let label : MainLabel = {
       let label = MainLabel()
        label.font = .Title2_R16
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraints()
        textField.textAlignment = .center
        textField.isEnabled = false
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(textField)
        addSubview(seperator)
        addSubview(label)
    }
    
    func addConstraints() {
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(48)
            make.trailing.equalTo(label.snp.leading).offset(-8)
            
        }
        seperator.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(textField)
            make.height.equalTo(1)
        }
        
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(20)
        }
        
        
    }
    
}

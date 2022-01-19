//
//  MainTextField.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/18.
//

import UIKit

class MainTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .Title4_R14
        textColor = .gray7
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

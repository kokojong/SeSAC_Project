//
//  MainButton.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/18.
//

import UIKit

public enum CSButtonType {
    case inactiveButton
    case fill
    case outline
    case cancel
    case disable
}


class MainButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        layer.cornerRadius = 8
        self.titleLabel?.font = .Body3_R14
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    convenience init(type: CSButtonType) {
        self.init()
        
        self.layer.cornerRadius = 8
        self.titleLabel?.font = .Body3_R14

        switch type {
        case .inactiveButton:
            self.clipsToBounds = true
            self.layer.borderColor = UIColor.gray4?.cgColor
            self.layer.borderWidth = 1
            self.backgroundColor = .white
            self.setTitleColor(.black, for: .normal)
            
        case .fill:
            self.backgroundColor = .green
            self.setTitleColor(.white, for: .normal)
        
        
        case .disable:
            self.backgroundColor = .gray6
            self.setTitleColor(.gray3, for: .normal)
            
        case .outline:
            self.clipsToBounds = true
            self.layer.borderColor = UIColor.green?.cgColor
            self.layer.borderWidth = 1
            self.backgroundColor = .white
            self.setTitleColor(.green, for: .normal)
            
        case .cancel:
            self.backgroundColor = .gray2
            self.setTitleColor(.black, for: .normal)
        }
        
      
    }
    
    var style: CSButtonType = .fill {
        didSet {
            switch style {
            case .fill :
                self.backgroundColor = .green
                self.setTitleColor(.white, for: .normal)
                
            case .disable :
                self.backgroundColor = .gray6
                self.setTitleColor(.gray3, for: .normal)
                
            case .inactiveButton:
                self.backgroundColor = .white
                self.setTitleColor(.black, for: .normal)
                
            case .outline:
                self.clipsToBounds = true
                self.layer.borderColor = UIColor.green?.cgColor
                self.layer.borderWidth = 1
                self.backgroundColor = .white
                self.setTitleColor(.green, for: .normal)
                
            case .cancel:
                self.backgroundColor = .gray2
                self.setTitleColor(.black, for: .normal)
            }
        }
    }
    

}

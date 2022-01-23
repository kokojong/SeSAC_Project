//
//  GenderView.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/21.
//

import UIKit
import SnapKit

public enum CSGenderViewType {
    case inactive
    case active
}

class GenderView : UIView {
    
    let genderImageview = UIImageView()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray3?.cgColor
        addGenderImageview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        addGenderImageview()
    }
    
    convenience init(type: CSGenderViewType) {
        self.init()
        
        addGenderImageview()
        
        self.layer.cornerRadius = 8
        
        switch type {
        case .inactive:
            self.backgroundColor = .white
      
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.gray3?.cgColor
            
        case .active:
            self.backgroundColor = .whiteGreen
        }
    }
    
    func addGenderImageview() {
        self.addSubview(genderImageview)
        genderImageview.contentMode = .scaleAspectFit
        genderImageview.snp.makeConstraints { make in
            make.center.equalToSuperview()
//            make.top.leading.equalToSuperview().inset(12)
            make.size.equalTo(64)
        }
    }
    
    var style: CSGenderViewType = .inactive {
        didSet {
            addGenderImageview()
            switch style {
            case .inactive:
                self.backgroundColor = .white
                self.layer.borderWidth = 1
                self.layer.borderColor = UIColor.gray3?.cgColor
                
            case .active:
                self.backgroundColor = .whiteGreen
            }
            
        }
        
    }
}

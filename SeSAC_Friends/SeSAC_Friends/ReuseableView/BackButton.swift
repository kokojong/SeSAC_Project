//
//  BackButton.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/08.
//

import UIKit
import SnapKit

class BackButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named: "arrow_back"), for: .normal)
        tintColor = .black
        
        snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//
//  MainLabel.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/18.
//

import UIKit

class MainLabel: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        numberOfLines = 0
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

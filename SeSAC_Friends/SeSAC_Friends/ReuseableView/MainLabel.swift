//
//  MainLabel.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/18.
//

import UIKit

class Display1Label: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .Display1_R20
        numberOfLines = 0
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class Title3Label: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .Title3_M14
        numberOfLines = 0
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

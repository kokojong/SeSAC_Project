//
//  UILabel+Extension.swift
//  SeSAC_week5_network
//
//  Created by kokojong on 2021/10/29.
//

import Foundation
import UIKit

extension UILabel {
    func setBorder() {
        self.backgroundColor = .red
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
}

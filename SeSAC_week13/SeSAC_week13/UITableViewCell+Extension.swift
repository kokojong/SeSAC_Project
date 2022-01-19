//
//  UITableViewCell+Extension.swift
//  SeSAC_week13
//
//  Created by kokojong on 2021/12/21.
//

import UIKit

protocol ReuseableView {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReuseableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    
}

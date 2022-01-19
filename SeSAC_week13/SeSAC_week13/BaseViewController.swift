//
//  BaseViewController.swift
//  SeSAC_week13
//
//  Created by kokojong on 2021/12/22.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        configure()
        setupConstraint()
    }
    
    func configure() {
        view.backgroundColor = .white
    }
    
    func setupConstraint() {
        
    }
    
}

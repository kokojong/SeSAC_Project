//
//  FrameworkVC.swift
//  SeSAC_week13
//
//  Created by kokojong on 2021/12/23.
//

import Foundation
import UIKit
import SeSAC_week13_framework

class FrameWorkViewController : UIViewController {

    override func viewDidLoad() {
        
//        let test = openVCTest()
//        test.name
//
//        test.openFunction()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let sesac = openVCTest()
        sesac.presentWebViewController(url: "https://www.naver.com", transitionStyle: .push, vc: self)
    }
}


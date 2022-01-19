//
//  ViewController.swift
//  SeSAC_week4_2
//
//  Created by kokojong on 2021/10/22.
//

import UIKit

/*
 Button Divice - 수평, 수직, 중앙
 button, label 등은 컨텐츠의 크기에 영향을 받음
 
 1. width, height : UIScreen.main.bounds.width
 2. device property
 3. device library
 
 
 */



class ViewController: UIViewController {

    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    
    var heightStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func blackButtonClicked(_ sender: UIButton) {
    
        heightStatus = !heightStatus
        containerViewHeight.constant = heightStatus ? UIScreen.main.bounds.width * 0.2 : 50
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}


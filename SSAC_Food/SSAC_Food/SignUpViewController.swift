//
//  SignUpViewController.swift
//  SSAC_Food
//
//  Created by kokojong on 2021/09/30.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        print("asdf")
        
    }
    

    @IBAction func tapClicked(_ sender: UITapGestureRecognizer) {
        // 키보드 내리기 - 편집이 끝났습니다~
        view.endEditing(true)
        
    }
    
}

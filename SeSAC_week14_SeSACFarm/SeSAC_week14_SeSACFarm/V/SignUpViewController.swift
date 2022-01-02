//
//  SignUpViewController.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/02.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let signUpView = SignUpView()
    
    var viewModel = SignUpViewModel()
    
    override func loadView() {
        self.view = signUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        signUpView.signUpButton.addTarget(self, action: #selector(onSignUpButtonClicked), for: .touchUpInside)
        
        
        
    }
    
    @objc func onSignUpButtonClicked() {
        
    }
    

  

}

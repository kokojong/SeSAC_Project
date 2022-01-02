//
//  MainViewController.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/01.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    let mainView = MainView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        mainView.signUpButton.addTarget(self, action: #selector(onSignUpButtonClicked), for: .touchUpInside)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewMapTapped))
        mainView.signInLabel.isUserInteractionEnabled = true
        mainView.signInLabel.addGestureRecognizer(tapGestureRecognizer)

    }
    
    @objc func onSignUpButtonClicked() {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    @objc func viewMapTapped(sender: UITapGestureRecognizer) {
        print("viewMapTapped")
        self.navigationController?.pushViewController(SignInViewController(), animated: true)
        
    }

    

  

}

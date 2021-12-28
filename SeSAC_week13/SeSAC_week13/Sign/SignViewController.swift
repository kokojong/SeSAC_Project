//
//  SignViewController.swift
//  SeSAC_week13
//
//  Created by kokojong on 2021/12/22.
//

import UIKit

class SignViewController: BaseViewController {
    
    var mainView = SignView()
    
    let viewModel = SignViewModel()
    
    // 뷰컨트롤러의 루트뷰를 로드할 때 호출되는 메서드
    // 새로운 뷰를 반환하려고 할 때 사용
    override func loadView() {
        self.view = mainView // mainView로 교체
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bind { text, color in
            self.mainView.passwordTextField.text = text
            self.mainView.passwordTextField.textColor = color
        }
        

    }
    
    override func configure() {
        mainView.emailTextField.placeholder = "이메일"
        mainView.emailTextField.text = viewModel.text
        mainView.signButton.addTarget(self, action: #selector(onSignButtonClicked), for: .touchUpInside)
        mainView.signButton.setTitle(viewModel.buttonTitle, for: .normal)
        
    }
    
    override func setupConstraint() {
        
    }
    
    @objc func onSignButtonClicked() {
        print(#function)
        guard let text = mainView.emailTextField.text else { return }
        viewModel.text = text
    }
    

}

//
//  HomeViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/22.
//

import UIKit
import SnapKit
import Toast

class HomeViewController: UIViewController {
    
    var idToken = UserDefaults.standard.string(forKey: "idToken")!
    
    let withdrawButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("회원 탈.퇴.", for: .normal)
        return button
        
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        monitorNetwork()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitorNetwork()
        
        view.backgroundColor = .yellow
        
        view.addSubview(withdrawButton)
        withdrawButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(200)
        }
        withdrawButton.addTarget(self, action: #selector(onWithdrawButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func onWithdrawButtonClicked() {
        
        APISevice.withdrawSignUp(idToken: idToken) { statuscode, error in
            self.view.makeToast("탈퇴 결과 코드 : \(statuscode)")
        }
        
    }
    

}

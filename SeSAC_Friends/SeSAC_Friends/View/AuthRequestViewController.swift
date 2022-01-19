//
//  AuthRequestViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/18.
//

import UIKit
import SnapKit
import FirebaseAuth

class AuthRequestViewController: UIViewController {
    
    let mainView = AuthCommonView()
    
    var phoneNumber = ""
    
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        mainView.mainButton.addTarget(self, action: #selector(onRequestButtonClicked), for: .touchUpInside)
        mainView.mainTextField.addTarget(self, action: #selector(onPhoneTextFieldChanged), for: .editingChanged)
    
        configViews()
        
        Auth.auth().languageCode = "kr"
    }
    
   

    func configViews() {
        mainView.mainLabel.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해주세요"
        mainView.mainTextField.placeholder = "휴대폰 번호 (-없이 숫자만 입력)"
//        mainView.mainButton.backgroundColor
        mainView.mainButton.setTitle("인증 문자 받기", for: .normal)
    }
    
    
    @objc func onRequestButtonClicked() {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print("error is ",error.localizedDescription)
                    return
                }
                
                print("verificationID ",verificationID)
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                
                // 성공하면 넘어감
                self.navigationController?.pushViewController(AuthCheckViewController(), animated: true)
                
            }
        // 일단 임시로 넘어가도록 처리
        self.navigationController?.pushViewController(AuthCheckViewController(), animated: true)
    }
    
    @objc func onPhoneTextFieldChanged() {
        phoneNumber = mainView.mainTextField.text ?? ""
        if phoneNumber.count > 0 {
            mainView.mainButton.style = .fill
        }
        
    }
    
    func isValidPhone(phone: String?) -> Bool {
        guard phone != nil else { return false }
        
        let phoneRegEx = "^010-?([0-9]{4})-?([0-9]{4})"
        let pred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return pred.evaluate(with: phone)
    }
    
    

}

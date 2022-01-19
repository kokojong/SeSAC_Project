//
//  AuthRequestViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/18.
//

import UIKit
import SnapKit
import FirebaseAuth
import Toast

class AuthRequestViewController: UIViewController {
    
    let mainView = AuthCommonView()
    
    var phoneNumber = ""
    
    var onlyPhoneNumber = ""
    
    
    
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
        if isValidPhone(phone: phoneNumber){
            onlyPhoneNumber = phoneNumber.components(separatedBy: ["-"]).joined()
            print("onlyPhoneNumber",onlyPhoneNumber)
            
            PhoneAuthProvider.provider()
                .verifyPhoneNumber("+82\(onlyPhoneNumber)", uiDelegate: nil) { verificationID, error in
                    if let error = error {
                        print("error is ",error.localizedDescription)
                        return
                    }
                    
                    print("verificationID ",verificationID)
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    
                    // 성공하면 넘어감
                    let vc = AuthCheckViewController()
                    vc.phoneNumber = self.phoneNumber
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
            
        } else {
            view.makeToast("잘못된 전화번호 형식입니다")
        }
        
        
    }
    
    @objc func onPhoneTextFieldChanged() {
        
        
        phoneNumber = mainView.mainTextField.text ?? ""
        mainView.mainTextField.text = phoneNumber.pretty()
        phoneNumber = mainView.mainTextField.text ?? ""
        
        print("phoneNumber", phoneNumber)
        if isValidPhone(phone: phoneNumber){
            mainView.mainButton.style = .fill
        } else {
            mainView.mainButton.style = .disable
        }
        
    }
    
    func isValidPhone(phone: String?) -> Bool {
        guard phone != nil else { return false }
        
        let phoneRegEx = "^010-?([0-9]{4})-?([0-9]{4})"
        let pred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return pred.evaluate(with: phone)
    }
    
    

}



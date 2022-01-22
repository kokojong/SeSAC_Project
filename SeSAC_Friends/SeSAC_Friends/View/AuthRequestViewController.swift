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
    
    var viewModel = AuthViewModel()
    
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
        
        Auth.auth().languageCode = "ko"
        
        viewModel.phoneNumber.bind { str in
            self.mainView.mainTextField.text = str
        }
        viewModel.isValidPhoneNumber.bind { valid in
            if valid {
                self.mainView.mainButton.style = .fill
            } else {
                self.mainView.mainButton.style = .disable
            }
        }
    }
    
   

    func configViews() {
        mainView.mainLabel.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해주세요"
        mainView.mainTextField.placeholder = "휴대폰 번호 (-없이 숫자만 입력)"
        mainView.mainTextField.keyboardType = .numberPad
        mainView.mainButton.setTitle("인증 문자 받기", for: .normal)
    }
    
    
    @objc func onRequestButtonClicked() {
        
        if viewModel.isValidPhoneNumber.value {
            // 임시로 넘어가기
            let vc = AuthCheckViewController()
            vc.viewModel = self.viewModel
            self.navigationController?.pushViewController(vc, animated: true)
            
            // 인증 번호 보내기(임시로 주석)
//            view.makeToast("휴대폰 번호 인증 시작")
//            viewModel.requestCode { verificationID, error in
//                guard let verificationID = verificationID else {
//                    // error가 존재
//                    print("error",error!.localizedDescription)
//                    print("error",error.debugDescription)
//
//                    switch error!.localizedDescription {
//                    case AuthResponse.blocked.rawValue: self.view.makeToast("과도한 인증 시도가 있었습니다.\n나중에 다시 시도해주세요")
//
//                    default:
//                        self.view.makeToast("에러가 발생했습니다.\n다시 시도해주세요")
//                    }
//
//                    return
//                }
//
//                self.viewModel.verificationID = verificationID
//                let vc = AuthCheckViewController()
//                vc.viewModel = self.viewModel
//                self.navigationController?.pushViewController(vc, animated: true)
//
//            }
             
            
        } else {
            // 키보드 내리기
            view.endEditing(true)
            view.makeToast("잘못된 전화번호 형식입니다")
        }
        
        
    }
    
    @objc func onPhoneTextFieldChanged() {
        
        viewModel.phoneNumber.value = mainView.mainTextField.text ?? ""
        viewModel.addHyphen()
        viewModel.onlyNumber.value = viewModel.phoneNumber.value.components(separatedBy: ["-"]).joined()
        viewModel.checkValidPhoneNumber(phone: viewModel.phoneNumber.value)
        
        
//        phoneNumber = mainView.mainTextField.text ?? ""
        
//        mainView.mainTextField.text = phoneNumber.toPhoneNumberPattern(pattern: "###-####-####", replacmentCharacter: "#")
        
//        print("phoneNumber", phoneNumber)
//        if isValidPhone(phone: phoneNumber){
//            mainView.mainButton.style = .fill
//        } else {
//            mainView.mainButton.style = .disable
//        }
//
    }
    
   
    
    
    

}



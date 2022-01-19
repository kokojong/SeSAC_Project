//
//  AuthCheckViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/18.
//

import UIKit
import SnapKit
import FirebaseAuth

class AuthCheckViewController: UIViewController {

    let mainView = AuthCommonView()
    
    let timerLabel: Title3Label = {
        let label = Title3Label()
        label.textColor = .green
        label.text = "05:00"
        
        return label
    }()
    
    let requestAgainButton = MainButton()
    
    var limitTime = 300
    
    var phoneNumber = ""
    var verificationCode = ""
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white

        addViews()
        addConstraints()
        configViews()
        updateConstraints()
        countDownTimer()
        
        mainView.mainButton.addTarget(self, action: #selector(onCheckButtonClicked), for: .touchUpInside)
        requestAgainButton.addTarget(self, action: #selector(onRequestAgainButtonClicked), for: .touchUpInside)
        mainView.mainTextField.addTarget(self, action: #selector(onCodeTextFieldChanged), for: .editingChanged)
        
    }
    
    @objc func onCheckButtonClicked() {
        
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")!
        
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: verificationCode

        )
       
        
        Auth.auth().signIn(with: credential) { (success, error) in
            if error == nil {
                print("success : ",success)
                print("로그인 성공!")
                
                self.navigationController?.pushViewController(AuthNicknameViewController(), animated: true)
                
            } else {
                print("error : ",error.debugDescription)
                
            }
            
        }
        
       
        
    }
    
    @objc func onRequestAgainButtonClicked() {
        limitTime = 300
        
        let onlyPhoneNumber = phoneNumber.components(separatedBy: ["-"]).joined()
        print("onlyPhoneNumber",onlyPhoneNumber)
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber("+82\(onlyPhoneNumber)", uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print("error is ",error.localizedDescription)
                    return
                }
                
                print("new verificationID ",verificationID)
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                
                
            }
        
        
    }
    
    func addViews() {
        self.view.addSubview(timerLabel)
        self.view.addSubview(requestAgainButton)
    }
    
    func addConstraints() {
        requestAgainButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(mainView.mainTextField.snp.top)
            make.bottom.equalTo(mainView.seperator.snp.bottom)
            make.height.equalTo(40)
            make.width.equalTo(72)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(mainView.mainTextField)
            make.trailing.equalTo(requestAgainButton.snp.leading).offset(-20)
            make.height.equalTo(22)
        }
    }
    
    func configViews() {
        mainView.mainLabel.text = "인증번호가 문자로 전송되었어요"
        mainView.mainTextField.placeholder = "인증번호 입력"
        mainView.mainButton.setTitle("인증하고 시작하기", for: .normal)
        
        requestAgainButton.setTitle("재전송", for: .normal)
        
        
    }
    
    func updateConstraints() {
        mainView.mainTextField.snp.updateConstraints { make in
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(120)
        }
        
    }
    
    func convertSecToTimer(sec: Int) {
        let minutes = (sec%3600)/60
        let seconds = (sec%3600)%60
        
        timerLabel.text = "\(minutes):\(String(format: "%02d", seconds))"
        
        if limitTime != 0 {
            perform(#selector(countDownTimer), with: nil, afterDelay: 1.0)
        }
        
    }
    
    @objc func countDownTimer() {
        convertSecToTimer(sec: limitTime)
        limitTime -= 1
    }
    
    @objc func onCodeTextFieldChanged() {
        verificationCode = mainView.mainTextField.text ?? ""
    }

}

//
//  AuthCheckViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/18.
//

import UIKit
import SnapKit
import FirebaseAuth
import Toast

class AuthCheckViewController: UIViewController {

    var viewModel: AuthViewModel!
    
    let mainView = AuthCommonView()
    
    let timerLabel: MainLabel = {
        let label = MainLabel()
        label.font = .Title3_M14
        label.textColor = .green
        label.text = "05:00"
        
        return label
    }()
    
    let subLabel = MainLabel()
    
    let requestAgainButton = MainButton(type: .fill)
    
    var limitTime = 60
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        monitorNetwork()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        limitTime = 60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitorNetwork()
        
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
        
        if isValidCode(code: self.viewModel.verificationCode) == false {
            view.makeToast("6자리의 인증번호를 입력해주세요")
            return
        }
        
        self.viewModel.checkCode { authresult, error  in
            
            guard authresult != nil else {
                self.view.makeToast("전화 번호 인증 실패")
                
                return
            }

            if error != nil {
                // 에러처리
                self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요")
                return
            }
            
            print("쳌쳌 성공")
            
            self.viewModel.getUserInfo { myUserInfo ,statuscode ,error in
                switch statuscode {
                case 200:
                    self.view.makeToast("이미 가입된 회원입니다.\n홈 화면으로 이동합니다.")
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
//                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: HomeViewController())
                        windowScene.windows.first?.rootViewController = TabBarViewController()
                        windowScene.windows.first?.makeKeyAndVisible()

                    }
                    
                case 201 :
                    self.view.makeToast("휴대폰 번호 인증에 성공했습니다.\n닉네임 설정 화면으로 이동합니다.")
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        let vc = AuthNicknameViewController()
                        vc.viewModel = self.viewModel
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: vc)
                        windowScene.windows.first?.makeKeyAndVisible()
                        
                        UIView.transition(with: windowScene.windows.first!, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
                        
                    }
                    
                   
                    
                    
                case 401: // 토큰 만료 -> 갱신
                    Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                        
                        if let error = error {
                            self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요.")
                            return
                        }
        
                        if let idToken = idToken {
                            print("idToken 갱신",idToken)
                            UserDefaults.standard.set(idToken, forKey: "idToken")
                        }
                
                    }
                default : // 기타 에러
                    self.view.makeToast("에러코드 : \(statuscode)")
                    
                }
                
            }
            
        }
       
        
    }
    
    @objc func onRequestAgainButtonClicked() {

        view.makeToast("인증번호가 재전송 되었습니다")
        
        let onlyPhoneNumber = viewModel.onlyNumber.value
        print("onlyPhoneNumber",onlyPhoneNumber)
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber("+82\(onlyPhoneNumber)", uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print("error is ",error.localizedDescription)
                    return
                }
                
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                self.viewModel.verificationID = verificationID!
                self.limitTime = 60
                
            }
        
        
    }
    
    func addViews() {
        self.view.addSubview(subLabel)
        self.view.addSubview(timerLabel)
        self.view.addSubview(requestAgainButton)
    }
    
    func addConstraints() {
        requestAgainButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(mainView.mainTextField.snp.top)
            make.bottom.equalTo(mainView.seperator.snp.bottom)
            make.height.equalTo(40)
            make.width.equalTo(75)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(mainView.mainTextField)
            make.trailing.equalTo(requestAgainButton.snp.leading).offset(-20)
            make.leading.equalTo(mainView.mainTextField.snp.trailing).offset(10)
            make.height.equalTo(22)
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerX.equalTo(mainView.mainLabel)
            make.top.equalTo(mainView.mainLabel.snp.bottom).offset(8)
        }
    }
    
    func configViews() {
        mainView.mainLabel.text = "인증번호가 문자로 전송되었어요"
        mainView.mainTextField.placeholder = "인증번호 입력"
        mainView.mainTextField.keyboardType = .numberPad
        mainView.mainButton.setTitle("인증하고 시작하기", for: .normal)
        
        subLabel.font = .Title2_R16
        subLabel.text = "(최대 20초 소요)"
        subLabel.textColor = .gray7
        
        requestAgainButton.setTitle("재전송", for: .normal)
        
    }
    
    func updateConstraints() {
        mainView.mainTextField.snp.updateConstraints { make in
            make.trailing.equalToSuperview().inset(150)
        }
        
    }
    
    func convertSecToTimer(sec: Int) {
        let minutes = (sec%3600)/60
        let seconds = (sec%3600)%60
        
        timerLabel.text = "\(minutes):\(String(format: "%02d", seconds))"
        
        if limitTime != 0 {
            perform(#selector(countDownTimer), with: nil, afterDelay: 1.0)
        } else { // 남은 시간 0초
            view.makeToast("휴대폰 번호 인증 실패")
        }
        
    }
    
    @objc func countDownTimer() {
        convertSecToTimer(sec: limitTime)
        limitTime -= 1
    }
    
    @objc func onCodeTextFieldChanged() {
        
        self.viewModel.verificationCode = mainView.mainTextField.text ?? ""
        if isValidCode(code: self.viewModel.verificationCode) {
            mainView.mainButton.style = .fill
        } else {
            mainView.mainButton.style = .disable
        }
      
    }

    func isValidCode(code: String?) -> Bool {
        guard code != nil else { return false }
        
        let codeRegEx = "([0-9]{6})"
        let pred = NSPredicate(format:"SELF MATCHES %@", codeRegEx)
        return pred.evaluate(with: code)
    }
    
}


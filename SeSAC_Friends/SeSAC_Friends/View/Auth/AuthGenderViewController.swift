//
//  AuthGenderViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/21.
//

import UIKit
import FirebaseAuth
import SnapKit
import Toast

class AuthGenderViewController: UIViewController {

    let mainView = AuthCommonView()
    
    let subLabel = MainLabel()
    
    var viewModel = AuthViewModel.shared
    
    var genderManView = GenderView(type: .inactive)
    
    var genderWomanView = GenderView(type: .inactive)

    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        monitorNetwork()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitorNetwork()
        
        view.backgroundColor = .white

        addViews()
        addConstraints()
        updateConstraints()
        configViews()
        
        mainView.mainButton.addTarget(self, action: #selector(onSignUpButtonClicked), for: .touchUpInside)
        
        viewModel.gender.bind { gender in
            switch gender {
            case 1:
                self.genderManView.style = .active
                self.genderWomanView.style = .inactive
                self.mainView.mainButton.style = .fill
            case 0:
                self.genderManView.style = .inactive
                self.genderWomanView.style = .active
                self.mainView.mainButton.style = .fill
            default:
                self.genderManView.style = .inactive
                self.genderWomanView.style = .inactive
                self.mainView.mainButton.style = .disable
                
            }
        }
        
        genderManView.setOnClickListener {
            if self.viewModel.gender.value != 1 {
                self.viewModel.gender.value = 1
            } else {
                self.viewModel.gender.value = -1
            }
        }
        
        genderWomanView.setOnClickListener {
            if self.viewModel.gender.value != 0 {
                self.viewModel.gender.value = 0
            } else {
                self.viewModel.gender.value = -1
            }
        }
        
 
    }
    
    @objc func onSignUpButtonClicked() {
        self.viewModel.signUpUserInfo { statuscode, error in
            switch statuscode {
            case UserStatusCodeCase.success.rawValue :
                self.view.makeToast("??????????????? ??????????????????\n??? ???????????? ???????????????.")
                
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//                    let vc = HomeViewController()
                    let vc = TabBarViewController()
                    
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: vc)
                    windowScene.windows.first?.makeKeyAndVisible()
                }
                
            case 201:
                self.view.makeToast("?????? ????????? ???????????????.")
                
            case UserStatusCodeCase.invalidNickname.rawValue :
                self.view.makeToast("????????? ??? ?????? ??????????????????.\n????????? ????????? ???????????? ???????????????")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.backTwoWhenNavigationControllerUsed()
                }
            case UserStatusCodeCase.firebaseTokenError.rawValue :
                self.refreshFirebaseIdToken { idToken, error in
                    
                    if let error = error {
                        self.view.makeToast("?????? ????????? ??????????????????. ???????????? ?????? ??????????????????.")
                        return
                    }
    
                    if let idToken = idToken {
                        UserDefaults.standard.set(idToken, forKey: UserDefaultKeys.idToken.rawValue)
                        
                        // ???????????? ?????????
                        self.onSignUpButtonClicked()
//
                    }
            
                }
            default :
                self.view.makeToast("??????????????? ??????????????????")
            }
        }
    }
    
    func addViews() {
        self.view.addSubview(subLabel)
        self.view.addSubview(genderManView)
        self.view.addSubview(genderWomanView)
    }
    
    func addConstraints() {
        subLabel.snp.makeConstraints { make in
            make.centerX.equalTo(mainView.mainLabel)
            make.top.equalTo(mainView.mainLabel.snp.bottom).offset(8)
        }
        
        genderManView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalTo(mainView.mainButton.snp.top).offset(-32)
        }
        
        genderWomanView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(32)
            make.leading.equalTo(genderManView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(mainView.mainButton.snp.top).offset(-32)
            make.width.equalTo(genderManView.snp.width)
        }
    }
    func updateConstraints() {
        mainView.mainLabel.snp.updateConstraints { make in
            make.bottom.equalTo(mainView.mainTextField.snp.top).inset(-120)
        }
        
    }
    
    func configViews() {
        mainView.mainLabel.text = "????????? ??????????????????"
        mainView.mainTextField.isHidden = true
        mainView.seperator.isHidden = true
        subLabel.text = "?????? ?????? ????????? ?????? ????????????!"
        mainView.mainButton.setTitle("????????????", for: .normal)
       
        genderManView.genderImageview.image = UIImage(named: "man")
        genderManView.genderLabel.text = "??????"
        genderWomanView.genderImageview.image = UIImage(named: "woman")
        genderWomanView.genderLabel.text = "??????"
        
    }


    func backTwoWhenNavigationControllerUsed(){
        let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        
        self.navigationController?.popToViewController(viewControllers[viewControllers.count - 4 ], animated: true)
        
    }
        
        
}


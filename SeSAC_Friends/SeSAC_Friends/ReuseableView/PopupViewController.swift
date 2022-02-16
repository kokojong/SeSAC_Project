//
//  PopupViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/15.
//

import UIKit
import SnapKit

class PopupViewController: UIViewController, UiViewProtocol {
    
    var otheruid = ""
    
    var popupCase = 0
    
    var viewModel = HomeViewModel.shared
    
    let mainView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .white
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .Body1_M16
        $0.textAlignment = .center
    }
    
    let subtitleLabel = UILabel().then {
        $0.textColor = .gray7
        $0.font = .Title4_R14
        $0.textAlignment = .center
    }
    
    let buttonStackView = UIStackView().then {
        $0.spacing = 8
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    let cancelButton = MainButton(type: .cancel).then {
        $0.setTitle("취소", for: .normal)
    }
    
    let okButton = MainButton(type: .fill).then {
        $0.setTitle("확인", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black?.withAlphaComponent(0.5)
        addViews()
        addConstraints()
        
        cancelButton.addTarget(self, action: #selector(onCancelButtonClicked), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(onOkButtonClicked), for: .touchUpInside)
        
        otheruid = UserDefaults.standard.string(forKey: UserDefaultKeys.otherUid.rawValue) ?? ""
        print(otheruid)
    }
    
    func addViews() {
        view.addSubview(mainView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(okButton)
    }
    
    func addConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.top).inset(16)
            make.leading.trailing.equalTo(mainView).inset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(mainView).inset(16)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(mainView).inset(16)
            make.bottom.equalTo(mainView.snp.bottom).inset(16)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        okButton.snp.makeConstraints { make in
            
            make.height.equalTo(48)
        }
    }
    
    @objc func onCancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onOkButtonClicked() {
        
        switch popupCase {
        case PopupVCCase.hobbyRequest.rawValue:
            
            viewModel.hobbyRequest(otheruid: self.otheruid) { statuscode, error in
                
                self.view.makeToast("\(statuscode)")
                
                switch statuscode {
                    
                case HobbyRequestStatusCodeCase.success.rawValue:
                    self.view.makeToast("취미 함께 하기 요청을 보냈습니다")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.dismiss(animated: true)
                    }
                case HobbyRequestStatusCodeCase.alreadyRecievedRequest.rawValue:
                    // MARK: 서로 요청 보낸 상태 -> 수락
                    self.viewModel.hobbyAccept(otheruid: self.otheruid) { statuscode, error in
                        
                        switch statuscode {
                        case HobbyAcceptStatusCodeCase.success.rawValue:
                            UserDefaults.standard.set(MyStatusCase.matched.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                            self.view.makeToast("상대방도 취미 함께 하기를 요청했습니다. 채팅방으로 이동합니다")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.navigationController?.pushViewController(HomeChattingViewController(), animated: true)
                            }
                            
                        case HobbyAcceptStatusCodeCase.alreadyOtherMatched.rawValue:
                            self.view.makeToast("상대방이 이미 다른 사람과 취미를 함께하는 중입니다")
                        case HobbyAcceptStatusCodeCase.otherCanceledMatcting.rawValue:
                            self.view.makeToast("상대방이 취미 함께 하기를 그만두었습니다")
                        case HobbyAcceptStatusCodeCase.alreadyIMatched.rawValue:
                            self.view.makeToast("앗! 누군가가 나의 취미 함께 하기를 수락하였어요!")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.viewModel.checkMyQueueStatus { myQueueStateResult, statuscode, error in
                                    // TODO: 내 상태 확인 -> 다음 동작(기획서)
                                    switch statuscode {
                                        
                                    // MARK: 상태 조회 성공, matched == 1
                                    case MyQueueStatusCodeCase.success.rawValue:
                                        UserDefaults.standard.set(MyStatusCase.matched.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                                        self.view.makeToast("상대방도 취미 함께 하기 요청을 했습니다. 채팅방으로 이동합니다")
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                            self.navigationController?.pushViewController(HomeChattingViewController(), animated: true)
                                        }
                                    case MyQueueStatusCodeCase.matchingCanceled.rawValue:
                                        self.view.makeToast("오랜 시간 동안 매칭 되지 않아 새싹 친구 찾기를 그만둡니다")
                                        UserDefaults.standard.set(MyStatusCase.normal.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                                            windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: HomeViewController())
                                            windowScene.windows.first?.makeKeyAndVisible()
                                        }
                                    default:
                                        self.view.makeToast("내 상태를 확인 할 수 없어요. 잠시 후 다시 시도해주세요")
                                    }
                                }
                            }
                            
                        default:
                            self.view.makeToast("요청에 실패했습니다. 잠시 후 다시 시도해주세요")
                            
                        }
                        
                    }
                case HobbyRequestStatusCodeCase.otherCanceledMatcting.rawValue:
                    self.view.makeToast("상대방이 취미 함께 하기를 그만두었습니다")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                    
                default:
                    self.view.makeToast("요청에 실패했습니다. 잠시 후 다시 시도해주세요")
                }
                
            }
            
        case PopupVCCase.hobbyAceept.rawValue:
            // 수락하기(받은 요청)
            viewModel.hobbyAccept(otheruid: otheruid) { statuscode, error in
                self.view.makeToast("\(statuscode)")
                switch statuscode {
                case HobbyAcceptStatusCodeCase.success.rawValue:
                    UserDefaults.standard.set(MyStatusCase.matched.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                    self.navigationController?.pushViewController(HomeChattingViewController(), animated: true)
                case HobbyAcceptStatusCodeCase.alreadyOtherMatched.rawValue:
                    self.view.makeToast("상대방이 이미 다른 사람과 취미를 함께하는 중입니다")
                case HobbyAcceptStatusCodeCase.otherCanceledMatcting.rawValue:
                    self.view.makeToast("상대방이 취미 함께 하기를 그만두었습니다")
                case HobbyAcceptStatusCodeCase.alreadyIMatched.rawValue:
                    self.view.makeToast("앗! 누군가가 나의 취미 함께 하기를 수락하였어요!")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.viewModel.checkMyQueueStatus { myQueueStateResult, statuscode, error in
                            // TODO: 내 상태 확인 -> 다음 동작(기획서)
                            switch statuscode {
                                
                            // MARK: 상태 조회 성공, matched == 1
                            case MyQueueStatusCodeCase.success.rawValue:
                                UserDefaults.standard.set(MyStatusCase.matched.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                                self.view.makeToast("채팅방으로 이동합니다")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.navigationController?.pushViewController(HomeChattingViewController(), animated: true)
                                }
                            case MyQueueStatusCodeCase.matchingCanceled.rawValue:
                                self.view.makeToast("오랜 시간 동안 매칭 되지 않아 새싹 친구 찾기를 그만둡니다")
                                UserDefaults.standard.set(MyStatusCase.normal.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: HomeViewController())
                                    windowScene.windows.first?.makeKeyAndVisible()
                                }
                            default:
                                self.view.makeToast("내 상태를 확인 할 수 없어요. 잠시 후 다시 시도해주세요")
                            }
                        }
                    }
                    
                default:
                    self.view.makeToast("요청수락에 실패했습니다. 잠시 후 다시 시도해주세요")
                }
                
                
                
                
            }
            
        default:
            print(popupCase)
        }
        
        
        
        
    }
    
}

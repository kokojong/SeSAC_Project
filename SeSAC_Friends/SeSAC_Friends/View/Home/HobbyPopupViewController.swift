//
//  PopupViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/15.
//

import UIKit
import SnapKit

class HobbyPopupViewController: UIViewController {
    
    var otheruid = ""
    
    var popupCase = 0
    
    var viewModel = HomeViewModel.shared
    
    let mainView = PopupView()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black?.withAlphaComponent(0.5)
        
        mainView.cancelButton.addTarget(self, action: #selector(onCancelButtonClicked), for: .touchUpInside)
        mainView.okButton.addTarget(self, action: #selector(onOkButtonClicked), for: .touchUpInside)
        
        otheruid = UserDefaults.standard.string(forKey: UserDefaultKeys.otherUid.rawValue) ?? ""
        print(otheruid)
    }
    
    @objc func onCancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onOkButtonClicked() {
        
        switch popupCase {
        case PopupVCCase.hobbyRequest.rawValue:
            
            viewModel.hobbyRequest(otheruid: self.otheruid) { statuscode, error in
                
                switch statuscode {
                    
                case HobbyRequestStatusCodeCase.success.rawValue:
                    self.view.makeToast("취미 함께 하기 요청을 보냈습니다")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.dismiss(animated: true, completion: nil)
                    }
                case HobbyRequestStatusCodeCase.alreadyRecievedRequest.rawValue:
                    // MARK: 서로 요청 보낸 상태 -> 수락
                    self.viewModel.hobbyAccept(otheruid: self.otheruid) { statuscode, error in
                        
                        switch statuscode {
                        case HobbyAcceptStatusCodeCase.success.rawValue:
                            UserDefaults.standard.set(MyStatusCase.matched.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                            self.view.makeToast("상대방도 취미 함께 하기를 요청했습니다. 채팅방으로 이동합니다")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.dismiss(animated: true, completion: nil)
                                self.navigationController?.pushViewController(HomeChattingViewController(), animated: true)
                            }
                            
                        case HobbyAcceptStatusCodeCase.alreadyOtherMatched.rawValue:
                            self.view.makeToast("상대방이 이미 다른 사람과 취미를 함께하는 중입니다")
                        case HobbyAcceptStatusCodeCase.otherCanceledMatcting.rawValue:
                            self.view.makeToast("상대방이 취미 함께 하기를 그만두었습니다")
                        case HobbyAcceptStatusCodeCase.alreadyIMatched.rawValue:
                            self.view.makeToast("앗! 누군가가 나의 취미 함께 하기를 수락하였어요! 채팅방으로 이동합니다")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
                        
                        self.dismiss(animated: true, completion: nil)
                        
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
                switch statuscode {
                case HobbyAcceptStatusCodeCase.success.rawValue:
                    UserDefaults.standard.set(MyStatusCase.matched.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                    self.dismiss(animated: true, completion: nil)
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

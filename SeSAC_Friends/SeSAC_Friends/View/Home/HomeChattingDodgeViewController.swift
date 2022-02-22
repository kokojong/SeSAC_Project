//
//  HomeChattingDodgeViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/21.
//

import UIKit
import SnapKit
import Then

class HomeChattingDodgeViewController: UIViewController {

    var viewModel = HomeViewModel.shared
    
    let popupView = PopupView().then {
        $0.titleLabel.text = "약속을 취소하시겠습니까?"
        $0.subtitleLabel.text = "약속을 취소하시면 패널티가 부과됩니다"
        $0.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.checkMyQueueStatus { myQueueStateResult, statuscode, error in
            
            UserDefaults.standard.set(myQueueStateResult?.matchedUid, forKey: UserDefaultKeys.otherUid.rawValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black?.withAlphaComponent(0.5)
        
        
        addViews()
        addConstraints()
        
        popupView.okButton.addTarget(self, action: #selector(onOkButtonClicked), for: .touchUpInside)
        popupView.cancelButton.addTarget(self, action: #selector(onCancelButtonClicked), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func addViews(){
        view.addSubview(popupView)
    }
    
    func addConstraints(){
        popupView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(156)
        }
    }
    

    @objc func onOkButtonClicked() {
        print(#function)
        viewModel.dodgeMatching(otheruid: UserDefaults.standard.string(forKey: UserDefaultKeys.otherUid.rawValue)!) { statuscode in
            
            guard let statuscode = statuscode else {
                return
            }
            
            switch statuscode {
            case DodgeStatusCodeCase.success.rawValue:
                UserDefaults.standard.set(MyStatusCase.normal.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                changeRootView(vc: TabBarViewController())
            case DodgeStatusCodeCase.unAuthorized.rawValue:
                self.view.makeToast("잘못된 상대입니다. 상대를 다시 확인해주세요")
            default:
//                self.view.makeToast("약속 취소에 실패했습니다. 잠시 후 다시 시도해주세요")
                self.view.makeToast("\(statuscode)")
            }
            
        }
        
    }
    
    @objc func onCancelButtonClicked() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }

}

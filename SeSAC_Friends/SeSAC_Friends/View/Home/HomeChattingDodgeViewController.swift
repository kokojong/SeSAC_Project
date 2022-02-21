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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = UIColor.black?.withAlphaComponent(0.5)
        
        addViews()
        addConstraints()
        
        popupView.okButton.addTarget(self, action: #selector(onOkButtonClicked), for: .touchUpInside)
        popupView.cancelButton.addTarget(self, action: #selector(onCancelButtonClicked), for: .touchUpInside)
        
        
    }
    
    func addViews(){
        view.addSubview(popupView)
    }
    
    func addConstraints(){
        popupView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }

    @objc func onOkButtonClicked() {
        print(#function)
    }
    
    @objc func onCancelButtonClicked() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }

}

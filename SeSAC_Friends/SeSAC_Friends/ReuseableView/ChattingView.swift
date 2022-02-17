//
//  ChattingView.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/17.
//

import UIKit
import SnapKit

class ChattingView: UIView, UiViewProtocol {
    
    let textView = UITextView().then {
        $0.tintColor = .black
        $0.backgroundColor = .yellow
        
    }
    
    let sendMessageButton = UIButton().then {
        $0.setImage(UIImage(named: "sendButton"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 8
        backgroundColor = .gray1
        
        addViews()
        addConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(textView)
        addSubview(sendMessageButton)
        
    }
    
    func addConstraints() {
        
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview().inset(14)
            make.trailing.equalTo(sendMessageButton.snp.leading).offset(-10)
        }
        
        sendMessageButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(14)
            make.size.equalTo(20)
        }
        
        
    }
    
    
}

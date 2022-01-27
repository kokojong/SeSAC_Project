//
//  ProfileDetailBottomView.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/27.
//

import UIKit
import Then

class ProfileDetailBottomView: UIView {
    
    let nameLabel = UILabel().then {
        $0.text = "내 성별"
    }
    
    let manButton = MainButton(type: .inactiveButton).then {
        $0.titleLabel?.font = .Title4_R14
        $0.backgroundColor = .blue
        $0.tintColor = .black
        $0.setTitle("남자", for: .normal)
    }
    
    let womanButton = MainButton(type: .fill).then {
        $0.setTitle("여자", for: .normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraints()
        configViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func addViews() {
        addSubview(nameLabel)
        addSubview(manButton)
        addSubview(womanButton)
    }
    
    func addConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(womanButton)
            make.trailing.equalTo(manButton.snp.leading).offset(8)
        }
        
        manButton.snp.makeConstraints { make in
            make.trailing.equalTo(womanButton.snp.leading).inset(-8)
            make.top.equalTo(womanButton)
            make.width.equalTo(56)
            make.height.equalTo(48)
        }
        
        womanButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(28)
            make.bottom.equalToSuperview()
            make.width.equalTo(56)
            make.height.equalTo(48)
        }
    }
    
    func configViews() {
        manButton.setTitle("남", for: .normal)
        manButton.tintColor = .blue
        
    }
}

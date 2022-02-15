//
//  EmptyResultView.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/14.
//

import UIKit
import SnapKit
import Then

class EmptyResultView: UIView, UiViewProtocol {
    
    let titleLabel = MainLabel().then {
        $0.font = .Title1_M16
        $0.textColor = .black
//        $0.text = "아쉽게도 주변 새싹이 없어요ㅠ"
    }
    
    let subtitleLabel = MainLabel().then {
        $0.font = .Title4_R14
        $0.textColor = .gray7
//        $0.text = "취미를 변경하거나 조금만 더 기다려 주세요"
    }
    
    let emptyResultImageView = UIImageView().then {
        $0.image = UIImage(named: "empty_result")
        $0.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addViews()
        addConstraints()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(emptyResultImageView)
    }
    
    func addConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        emptyResultImageView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-36)
            make.centerX.equalToSuperview()
        }
    }
    
    
}

//empty_result

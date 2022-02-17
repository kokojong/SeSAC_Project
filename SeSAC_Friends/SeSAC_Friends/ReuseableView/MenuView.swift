//
//  MenuView.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/18.
//

import UIKit
import SnapKit
import Then

class MenuView: UIView, UiViewProtocol {
    
    let mainStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 0
        $0.axis = .horizontal
    }
    
    let reportStackView = UIStackView().then {
        $0.distribution = .fillProportionally
        $0.spacing = 4
        $0.axis = .vertical
    }
    
    let reportButton = UIButton().then {
        $0.setImage(UIImage(named: "report_match"), for: .normal)
    }
    
    let reportLabel = UILabel().then {
        $0.text = "새싹 신고"
        $0.font = .Title3_M14
        $0.textAlignment = .center
    }
    
    
    let dodgeStackView = UIStackView().then {
        $0.distribution = .fillProportionally
        $0.spacing = 4
        $0.axis = .vertical
    }
    
    let dodgeButton = UIButton().then {
        $0.setImage(UIImage(named: "dodge_match"), for: .normal)
    }
    
    let dodgeLabel = UILabel().then {
        $0.text = "약속 취소"
        $0.font = .Title3_M14
        $0.textAlignment = .center
    }
    
    let rateStackView = UIStackView().then {
        $0.distribution = .fillProportionally
        $0.spacing = 4
        $0.axis = .vertical
    }
    
    
    let rateButton = UIButton().then {
        $0.setImage(UIImage(named: "rate_match"), for: .normal)
    }
    
    let rateLabel = UILabel().then {
        $0.text = "리뷰 등록"
        $0.font = .Title3_M14
        $0.textAlignment = .center
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
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(reportStackView)
        reportStackView.addArrangedSubview(reportButton)
        reportStackView.addArrangedSubview(reportLabel)
        
        mainStackView.addArrangedSubview(dodgeStackView)
        dodgeStackView.addArrangedSubview(dodgeButton)
        dodgeStackView.addArrangedSubview(dodgeLabel)
        
        mainStackView.addArrangedSubview(rateStackView)
        rateStackView.addArrangedSubview(rateButton)
        rateStackView.addArrangedSubview(rateLabel)
        
        
    }
    
    func addConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}

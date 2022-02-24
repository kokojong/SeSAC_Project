//
//  ChattingHeaderTableViewCell.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/24.
//

import UIKit
import SnapKit
import Then

class ChattingHeaderTableViewCell: UITableViewCell, UiViewProtocol {
    
    static let identifier = "ChattingHeaderTableViewCell"
    
    private let titleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 4
    }
    
    private let alarmImageView = UIImageView().then {
        $0.image = UIImage(named: "bell")
    }
    
    let titleLabel = UILabel().then {
        $0.font = .Title3_M14
        $0.textColor = .gray7
    }
    
    private let subtitleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .Title4_R14
        $0.textColor = .gray6
        $0.text = "채팅을 통해 약속을 정해보세요 :)"
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(titleStackView)
        titleStackView.addArrangedSubview(alarmImageView)
        titleStackView.addArrangedSubview(titleLabel)
        addSubview(subtitleLabel)
        
    }
    
    func addConstraints() {
        titleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
    
    }
}

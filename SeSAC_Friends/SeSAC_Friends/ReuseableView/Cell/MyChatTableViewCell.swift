//
//  MyChatTableViewCell.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/19.
//

import UIKit
import SnapKit
import Then

class MyChatTableViewCell: UITableViewCell, UiViewProtocol {

    var viewModel = HomeViewModel.shared

    static let identifier = "MyChatTableViewCell"
    
    let borderView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.backgroundColor = .whiteGreen
    }
    
    let messageLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .Body3_R14
        $0.numberOfLines = 0
    }
    
    let timeLabel = UILabel().then {
        $0.textColor = .green
        $0.font = .Title6_R12
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
        addSubview(borderView)
        addSubview(messageLabel)
        addSubview(timeLabel)
    }
    
    func addConstraints() {
        
        borderView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(16)
            make.width.lessThanOrEqualTo(264)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(borderView).inset(10)
            make.leading.trailing.equalTo(borderView).inset(16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(borderView)
            make.trailing.equalTo(borderView.snp.leading).offset(-8)
        }
        
        
    }
}

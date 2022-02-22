//
//  OtherChatTableViewCell.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/20.
//

import UIKit
import SnapKit
import Then

class OtherChatTableViewCell: UITableViewCell, UiViewProtocol {

    var viewModel = HomeViewModel.shared

    static let identifier = "OtherChatTableViewCell"
    
    let borderView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray4?.cgColor
    }
    
    let messageLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .Body3_R14
        $0.numberOfLines = 0
    }
    
    let timeLabel = UILabel().then {
        $0.textColor = .gray6
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
            make.leading.equalToSuperview().inset(16)
            make.width.lessThanOrEqualTo(264)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(borderView).inset(10)
            make.leading.trailing.equalTo(borderView).inset(16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(borderView)
            make.leading.equalTo(borderView.snp.trailing).offset(8)
//            make.trailing.greaterThanOrEqualToSuperview().inset(57).priority(.high)
        }
        
        
    }
}

//
//  OpenedTableViewCell.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/26.
//

import UIKit
import SnapKit

class ClosedTableViewCell: UITableViewCell {
    
    static let identifier = "ClosedTableViewCell"
    
    let nicknameLabel = UILabel()
    
    let moreButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        addConstraints()
        configViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(nicknameLabel)
        addSubview(moreButton)
    }
    
    func addConstraints() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
            make.trailing.equalTo(moreButton.snp.leading).inset(16)
            
            
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            
        }
        
    }
    
    func configViews() {
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.gray2?.cgColor
        self.layer.borderWidth = 1
        
        nicknameLabel.textColor = .black
        nicknameLabel.font = .Title1_M16
        
    }
}

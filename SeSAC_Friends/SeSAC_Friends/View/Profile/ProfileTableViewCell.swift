//
//  ProfileTableViewCell.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/25.
//

import UIKit
import SnapKit

class ProfileTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileTableViewCell"
    
    let iconImageView = UIImageView()
    
    let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.isUserInteractionEnabled = true
        
        iconImageView.contentMode = .scaleAspectFit
        
        titleLabel.font = .Title2_R16
        titleLabel.textColor = .black
        
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setViews() {
        addSubview(iconImageView)
        addSubview(titleLabel)
    }
    
    func setConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(24)
            make.size.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(14)
            make.trailing.equalToSuperview().inset(14)
            make.top.bottom.equalToSuperview().inset(24)
        }
        
    }
}

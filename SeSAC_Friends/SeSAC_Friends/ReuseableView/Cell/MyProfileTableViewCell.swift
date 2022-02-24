//
//  MyProfileTableViewCell.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/25.
//

import UIKit
import SnapKit

class MyProfileTableViewCell: UITableViewCell {

    static let identifier = "MyProfileTableViewCell"
    
    let profileImageView = UIImageView()
    
    let usernameLabel = UILabel()
    
    let moreButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.isUserInteractionEnabled = true
        
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.image = UIImage(named: "profile_img")
        
        usernameLabel.textColor = .black
        usernameLabel.font = .Title1_M16
        
        moreButton.setImage(UIImage(named: "more_arrow_right"), for: .normal)
        
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(moreButton)
    }
    
    func addConstraints() {
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview().inset(20)
            make.size.equalTo(50)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(30)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.trailing.equalTo(moreButton.snp.leading).offset(12)
            
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(22)
            make.width.equalTo(9)
            make.height.equalTo(18)
            
        }
        
    }

}

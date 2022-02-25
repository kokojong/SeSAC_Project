//
//  CommentTableViewCell.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/05.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    static let identifier = "CommentTableViewCell"
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 1
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    let optionButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "ellipsis.vertical"), for: .normal)
        button.tintColor = .black
        return button
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.isUserInteractionEnabled = true
        
        setViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        addSubview(nicknameLabel)
        addSubview(contentLabel)
        addSubview(optionButton)
//        optionButton.backgroundColor = .yellow
    }
    
    func setConstraints() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalTo(optionButton.snp.leading).offset(-8)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalTo(optionButton.snp.leading).offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        optionButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.top)
            make.trailing.equalToSuperview().offset(-8)
            make.size.equalTo(30)
        }
    }

}

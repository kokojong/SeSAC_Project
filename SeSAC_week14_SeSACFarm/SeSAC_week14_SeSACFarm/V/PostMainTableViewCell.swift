//
//  PostMainTableViewCell.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/03.
//

import UIKit

class PostMainTableViewCell: UITableViewCell {
    
    static let identifier = "PostMainTableViewCell"
    
    let nicknameLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.backgroundColor = .lightGray
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        label.font = .boldSystemFont(ofSize: 10)
        label.textColor = .darkGray
        
        return label
    }()

    let contentLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        
        return label
    }()
    
    let createdDateLabel: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 10)
        return label
        
    }()
    
    let lineView: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let bottomStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let chatImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "message")
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    let goToCommentLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()
    
    let spacingView: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        addSubview(nicknameLabel)
        addSubview(contentLabel)
        addSubview(createdDateLabel)
        addSubview(lineView)
        addSubview(bottomStackView)
        addSubview(spacingView)
        bottomStackView.addArrangedSubview(chatImageView)
        bottomStackView.addArrangedSubview(goToCommentLabel)
      
    }
    
    func setConstraints() {
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(8)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        createdDateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(createdDateLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(1)
        }
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
//            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(20)
        }
        spacingView.snp.makeConstraints { make in
            make.top.equalTo(bottomStackView.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(16)
        }
        
        
        
    }

}

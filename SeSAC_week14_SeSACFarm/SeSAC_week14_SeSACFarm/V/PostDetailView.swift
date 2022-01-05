//
//  PostDetailView.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/04.
//

import UIKit

class PostDetailView: UIView {

    let profileImageView: UIImageView = {
       let imageview = UIImageView()
        imageview.image = UIImage(systemName: "person.circle")
        imageview.contentMode = .scaleAspectFit
        
        return imageview
    }()
    
    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        
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
    
    let lineView2: UIView = {
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
    
    let commentsTableView = UITableView()
    
    let commentTextField : UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .lightGray
        textfield.placeholder = "댓글을 입력해주세요"
        return textfield
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        addSubview(profileImageView)
        addSubview(nickNameLabel)
        addSubview(contentLabel)
        addSubview(createdDateLabel)
        addSubview(lineView)
        addSubview(lineView2)
        addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(chatImageView)
        bottomStackView.addArrangedSubview(goToCommentLabel)
        addSubview(commentsTableView)
        addSubview(commentTextField)
    }
    
    func setConstraints() {
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(profileImageView.snp.height)
            make.bottom.equalTo(createdDateLabel.snp.bottom)
        }
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        createdDateLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(1)
        }
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(20)
        }
        lineView2.snp.makeConstraints { make in
            make.top.equalTo(bottomStackView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(1)
        }
       
        commentsTableView.snp.makeConstraints { make in
            make.top.equalTo(lineView2.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        commentTextField.snp.makeConstraints { make in
            make.top.equalTo(commentsTableView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-8)
            make.height.equalTo(44)
        }
    }

}

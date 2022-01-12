//
//  PostDetailView.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/04.
//

import UIKit

class PostDetailTableView: UIView {
    
    let commentsTableView = UITableView(frame: .zero, style: .grouped)
    
    let writeCommentButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        button.tintColor = .black
        return button
    }()


    let commentTextField: UITextField = {
       let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.clipsToBounds = true
        textField.backgroundColor = .lightGray
        textField.textColor = .black
        textField.placeholder = "댓글을 입력해주세요"
        textField.addLeftPadding()
        return textField
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
        addSubview(commentsTableView)
        addSubview(commentTextField)
        addSubview(writeCommentButton)
    }
    
    func setConstraints() {
        
        commentsTableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(commentTextField.snp.top).offset(-16)
        }
        
        commentTextField.snp.makeConstraints { make in
            
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalTo(writeCommentButton.snp.leading)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-8)
            make.height.equalTo(44)
        }
        
        
        writeCommentButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(commentTextField)
            make.trailing.equalToSuperview().inset(8)
            make.width.equalTo(writeCommentButton.snp.height)
        }
        
        
    }

}


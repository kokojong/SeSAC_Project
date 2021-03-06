//
//  CommentWriteView.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/12.
//

import UIKit

class CommentWriteView: UIView {
    
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
        
        addSubview(commentTextField)
        addSubview(writeCommentButton)
        
    }
    
    func setConstraints() {
        
        commentTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        
        writeCommentButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(commentTextField)
            make.leading.equalTo(commentTextField.snp.trailing)
            make.trailing.equalToSuperview().inset(8)
            make.width.equalTo(writeCommentButton.snp.height)
        }
        
        
    }
    

}

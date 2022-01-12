//
//  PostDetailView.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/04.
//

import UIKit

class PostDetailTableView: UIView {
    
    let commentsTableView = UITableView(frame: .zero, style: .grouped)
    
    let commentWriteView  = CommentWriteView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
        self.commentsTableView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        addSubview(commentsTableView)
        addSubview(commentWriteView)
    }
    
    func setConstraints() {
        commentsTableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        commentWriteView.snp.makeConstraints { make in
            make.top.equalTo(commentsTableView.snp.bottom).inset(16)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(44)
        }
    }

}


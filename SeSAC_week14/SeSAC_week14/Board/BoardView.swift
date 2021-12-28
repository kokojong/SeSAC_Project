//
//  BoardView.swift
//  SeSAC_week14
//
//  Created by kokojong on 2021/12/28.
//

import UIKit
import SnapKit

protocol boardViewRepresentable {
    func setupView()
    func setupConstraints()
}

class BoardView: UIView, boardViewRepresentable {
    
    let textLabel = UILabel()
    let usernameLabel = UILabel()
    let emailLabel = UILabel()
    let uploadDateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(textLabel)
        textLabel.backgroundColor = .yellow
        
        addSubview(usernameLabel)
        usernameLabel.backgroundColor = .orange
        
        addSubview(emailLabel)
        emailLabel.backgroundColor = .green
        
        addSubview(uploadDateLabel)
        uploadDateLabel.backgroundColor = .blue
    }
    
    func setupConstraints() {
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        uploadDateLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        
    }
    
    
    
}

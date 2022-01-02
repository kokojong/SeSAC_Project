//
//  MainView.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/02.
//

import UIKit

class MainView: UIView {

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    
    let logoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.text = "새싹농장"
        label.textAlignment = .center
        return label
    }()
    
    let logoSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "새싹농장에서 놀아요오옹\n잭님과 함께하는 바람의 나라(?)"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let signUpButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .green
        button.tintColor = .white
        button.setTitle("회원가입", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    let signInStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    let signInTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "이미 계정이 있다면?"
        return label
    }()
    
    let signInLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .green
        label.text = "로그인"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(logoImageView)
        addSubview(logoTitleLabel)
        addSubview(logoSubtitleLabel)
        addSubview(signUpButton)
        addSubview(signInStackView)
        
        signInStackView.addArrangedSubview(signInTextLabel)
        signInStackView.addArrangedSubview(signInLabel)
        
    }
    
    func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        logoTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(logoImageView).inset(-40)
            make.top.equalTo(logoImageView.snp.bottom).offset(8)
        }
        
        logoSubtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(logoTitleLabel)
            make.top.equalTo(logoTitleLabel.snp.bottom)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(signInStackView.snp.top).offset(-8)
            make.height.equalTo(44)
            
        }
        
        signInStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
        }
        
        
    }
    
}

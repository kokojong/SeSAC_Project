//
//  BeerDescriptionView.swift
//  SeSAC_week13_BeerCheers
//
//  Created by kokojong on 2021/12/30.
//

import Foundation
import UIKit

protocol BeerDescriptionViewRepresentable {
    func setupView()
    func setupConstraints()
}

class BeerDescriptionView: UIView, BeerDescriptionViewRepresentable {
    
    let nameLabel = UILabel()
    let taglineLabel = UILabel()
    let descriptionLabel = UILabel()
    let moreButton = UIButton()
    
    var viewModel = BeerViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(nameLabel)
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.text = "Hello My Name Is Ingrid 2016"
        
        addSubview(taglineLabel)
        taglineLabel.font = .systemFont(ofSize: 15)
        taglineLabel.text = "Cloudberry Double IPA"
        
        addSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 3
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.text = "We asked the public to tell us the one beer we should brew again, from our entire back catalogue. They chose well. Cloudberries team up with pan-global hops for an all out fruit riot against a caramel malt base. We asked the public to tell us the one beer we should brew again, from our entire back catalogue. They chose well. Cloudberries team up with pan-global hops for an all out fruit riot against a caramel malt base."
        
        addSubview(moreButton)
        moreButton.setTitle("more", for: .normal)
//        moreButton.titleLabel?.font = .boldSystemFont(ofSize: 13)
        moreButton.backgroundColor = .red
        
        moreButton.addTarget(self, action: #selector(onMoreButtonClicked), for: .touchUpInside)
    }
    
    @objc func onMoreButtonClicked() {
        print("more")
        viewModel.descriptionViewHeight.value = 100
//        viewModel.updateHeight(100)
        print(viewModel.descriptionViewHeight.value)
    }
    
    func setupConstraints() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        
        taglineLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(taglineLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(20)
        
        }
        
    }
    
}

//
//  BeerTableHeaderView.swift
//  SeSAC_week13_BeerCheers
//
//  Created by kokojong on 2021/12/30.
//

import UIKit

protocol BeerTableHeaderViewRepresentable {
    func setupView()
    func setupConstraints()
}

class BeerTableHeaderView: UIView, BeerTableHeaderViewRepresentable {
    
    
    
    let beerImageView = UIImageView()
    let descriptionUIView = BeerDescriptionView()
    let backgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
//        descriptionUIView.viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setupView() {
        addSubview(beerImageView)
        beerImageView.backgroundColor = .magenta
        
        addSubview(backgroundView)
        backgroundView.backgroundColor = .white
        
        addSubview(descriptionUIView)
        descriptionUIView.backgroundColor = .lightGray
        descriptionUIView.layer.cornerRadius = 8
    }
    
    func setupConstraints() {
        
        beerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(descriptionUIView).multipliedBy(1)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(beerImageView.snp.bottom)
//            make.height.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(descriptionUIView).multipliedBy(0.6)
        }
        
        descriptionUIView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.6)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            
        }
    }
    
    
}

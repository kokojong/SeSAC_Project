//
//  BottomView.swift
//  SeSAC_week13_BeerCheers
//
//  Created by kokojong on 2021/12/30.
//

import UIKit

protocol BottomViewRepresentable {
    func setupView()
    func setupConstraints()
}

class BottomView: UIView, BottomViewRepresentable {
    
    var refreshButton = UIButton()
    var shareButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(refreshButton)
        refreshButton.backgroundColor = .systemMint
        refreshButton.setTitle("refresh", for: .normal)
        refreshButton.layer.cornerRadius = 8
        
        addSubview(shareButton)
        shareButton.backgroundColor = .magenta
        shareButton.setTitle("share", for: .normal)
        shareButton.layer.cornerRadius = 8
    }
    
    func setupConstraints() {
        refreshButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(refreshButton.snp.height)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalTo(refreshButton.snp.trailing).offset(20)
        }
        
    }
    

  

}

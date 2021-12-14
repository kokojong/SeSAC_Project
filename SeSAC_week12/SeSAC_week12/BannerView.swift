//
//  BannerView.swift
//  SeSAC_week12
//
//  Created by kokojong on 2021/12/13.
//


import UIKit

class BannerView: UIView {
    
    let mainLabel = UILabel()
    let descriptionLabel = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("override init")
        loadLayout()
    }
    
    // 실패가 가능한 이니셜라이저
    required init?(coder: NSCoder) {
        print("required init")
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadLayout() {
        mainLabel.font = .boldSystemFont(ofSize: 15)
        mainLabel.textColor = .black
        mainLabel.text = "메인"
        descriptionLabel.font = .boldSystemFont(ofSize: 20)
        descriptionLabel.textColor = .blue
        descriptionLabel.text = "설명"
        
        mainLabel.frame = CGRect(x: 30, y: 30, width: UIScreen.main.bounds.width - 130, height: 40)
        descriptionLabel.frame = CGRect(x: 30, y: 80, width: UIScreen.main.bounds.width - 130, height: 30)
        
        self.addSubview(mainLabel)
        self.addSubview(descriptionLabel)
    }
    
    
}

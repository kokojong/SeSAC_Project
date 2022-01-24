//
//  OnboardingView.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/24.
//

import UIKit
import SnapKit

class OnboardingView: UIView {

    let imageView = UIImageView()
    

    
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addViews()
        addConstraints()
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "NotoSansKR-Regular", size: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black

        
        imageView.contentMode = .scaleAspectFit
      
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    func addViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        
    }
    
    func addConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(imageView.snp.width).priority(.high)
            
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(imageView.snp.top)
            
        }
        
    }
}



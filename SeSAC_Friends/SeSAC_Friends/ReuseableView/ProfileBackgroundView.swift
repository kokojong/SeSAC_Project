//
//  ProfileBackgroundView.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/26.
//

import UIKit
import SnapKit

class ProfileBackgroundView: UIView {

    let backgroundImageView = UIImageView()
    
    let faceImageView = UIImageView()
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        configImageView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configImageView() {
        addSubview(backgroundImageView)
        addSubview(faceImageView)
        
        backgroundImageView.layer.cornerRadius = 8
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: "sesac_bg_01")
        faceImageView.image = UIImage(named: "sesac_face")
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        faceImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(9)
            make.size.equalTo(184)
        }
    }

}

//
//  ProfileBackgroundView.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/26.
//

import UIKit
import SnapKit

class ProfileBackgroundView: UIView {

    let backgroundImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    let faceImageView = UIImageView()
    
    let matchButton = MainButton(type: .fill)
 
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
        addSubview(matchButton)
        
        backgroundImageView.layer.cornerRadius = 8
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: "sesac_background_1")
        faceImageView.image = UIImage(named: "sesac_face_1")
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        faceImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(9)
            make.size.equalTo(184)
        }
        
        matchButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(12)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
    }

}

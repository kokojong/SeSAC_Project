//
//  HomeNearHobbyCollectionVIewCell.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/08.
//

import UIKit
import SnapKit
import Then

class HomeNearHobbyCollectionVIewCell: UICollectionViewCell {
    
    let borderView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray4?.cgColor
        $0.backgroundColor = .white
    }
    
    let hobbyLabel = UILabel().then {
        $0.font = .Title4_R14
        $0.numberOfLines = 0
    }
    
    static let identifier = "HomeNearHobbyCollectionVIewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(borderView)
        contentView.addSubview(hobbyLabel)
        layoutIfNeeded()
        borderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        hobbyLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

//
//  HomeFavoriteHobbyCollectionViewCell.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/09.
//

import UIKit
import SnapKit
import Then

class HomeFavoriteHobbyCollectionViewCell: UICollectionViewCell {
    
    let borderView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.green?.cgColor
        $0.backgroundColor = .white
    }
    
    let hobbyLabel = UILabel().then {
        $0.font = .Title4_R14
        $0.numberOfLines = 0
        $0.textColor = .green
    }
    
    let deleteImage = UIImageView().then {
        $0.image = UIImage(named: "close_small")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .green
        
    }
    
    static let identifier = "HomeFavoriteHobbyCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(borderView)
        contentView.addSubview(hobbyLabel)
        contentView.addSubview(deleteImage)
        layoutIfNeeded()
        borderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        hobbyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        deleteImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(hobbyLabel.snp.trailing).offset(4)
            make.size.equalTo(16)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

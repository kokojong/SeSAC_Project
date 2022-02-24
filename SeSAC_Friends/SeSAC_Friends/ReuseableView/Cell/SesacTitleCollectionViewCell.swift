//
//  SesacTitleCollectionViewCell.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/26.
//

import UIKit
import SnapKit

class SesacTitleCollectionViewCell: UICollectionViewCell {
    
    let button = MainButton(type: .inactiveButton)
    
    static let identifier = "SesacTitleCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        
        layoutIfNeeded()
        let size = systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.width = ceil(size.width)
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        //isSizeCalculated = true
        return layoutAttributes

        
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

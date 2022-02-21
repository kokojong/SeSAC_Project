//
//  ChattingRateCollectionViewCell.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/20.
//

import UIKit
import SnapKit
import Then

class ChattingRateCollectionViewCell: UICollectionViewCell {
    
    let rateButton = MainButton(type: .inactiveButton).then {
        $0.setTitle("rateButton", for: .normal)
    }
    
    static let identifier = "ChattingRateCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(rateButton)
        rateButton.isUserInteractionEnabled = false
        rateButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                rateButton.style = .fill
            } else {
                rateButton.style = .inactiveButton
            }
        }
    }
}

//
//  TVShowCollectionViewCell.swift
//  SeSAC_week13_Drama
//
//  Created by kokojong on 2021/12/22.
//

import UIKit
import SnapKit

class TVShowCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "TVShowCollectionViewCell"
    
    let posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setupView() {
        self.backgroundColor = .lightGray
        self.addSubview(posterImageView)
    }
    
    func setupConstraint() {
        posterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//
//  BeerDescriptionView.swift
//  SeSAC_week13_BeerCheers
//
//  Created by kokojong on 2021/12/30.
//

import Foundation
import UIKit

protocol BeerDescriptionViewRepresentable {
    func setupView()
    func setupConstraints()
}

class BeerDescriptionView: UIView, BeerDescriptionViewRepresentable {
    
    let nameLabel = UILabel()
    let taglineLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        
    }
    
    func setupConstraints() {
        
    }
    
    
}

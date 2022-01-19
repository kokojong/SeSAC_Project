//
//  TVShowView.swift
//  SeSAC_week13_Drama
//
//  Created by kokojong on 2021/12/29.
//

import UIKit
import SnapKit

protocol TVshowViewRepresentable {
    func setupView()
    func setupConstraints()
}

class TVShowView: UIView, TVshowViewRepresentable {
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10

        layout.scrollDirection = .vertical // 가로로 먼저 쌓이게 함
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return cv
    }()
    
    let searchTextField = UISearchTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(collectionView)
        collectionView.backgroundColor = .green
        
        addSubview(searchTextField)
        
    }
    
    func setupConstraints() {
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        collectionView.backgroundColor = .blue
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
    }
    
}


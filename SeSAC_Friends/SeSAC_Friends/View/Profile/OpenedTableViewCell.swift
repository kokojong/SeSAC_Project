//
//  OpenedTableViewCell.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/26.
//

import UIKit
import SnapKit
import Then

class OpenedTableViewCell: UITableViewCell {
    
    static let identifier = "OpenedTableViewCell"
    
    let nicknameLabel = UILabel()
    
    let moreButton = UIButton()
    
    let sesacTitleLabel = UILabel()
    
    let sesacTitleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        
        $0.register(SesacTitleCollectionViewCell.self, forCellWithReuseIdentifier: SesacTitleCollectionViewCell.identifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let inset: CGFloat = 16
        flowLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        let totalWidth = UIScreen.main.bounds.width - 4*inset - spacing
        flowLayout.itemSize = CGSize(width:totalWidth/2, height: 32)
        flowLayout.minimumLineSpacing = spacing
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.scrollDirection = .vertical
        
        $0.collectionViewLayout = flowLayout
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
        setConstraints()
        configViews()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        addSubview(nicknameLabel)
        addSubview(moreButton)
        addSubview(sesacTitleLabel)
        addSubview(sesacTitleCollectionView)
    }
    
    func setConstraints() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
            make.trailing.equalTo(moreButton.snp.leading).inset(16)
            
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            
        }
        
        sesacTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).inset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        sesacTitleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            
        }
        
    }
    
    func configViews() {
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.gray2?.cgColor
        self.layer.borderWidth = 1
        
        nicknameLabel.textColor = .black
        nicknameLabel.font = .Title1_M16
        
        sesacTitleLabel.font = .Title6_R12
        sesacTitleLabel.textColor = .black
        sesacTitleLabel.text = "새싹 타이틀"
        
//        sesacTitleCollectionView.register(SesacTitleCollectionViewCell.self, forCellWithReuseIdentifier: SesacTitleCollectionViewCell.identifier)
        
//        let flowLayout = UICollectionViewFlowLayout()
//        let spacing: CGFloat = 8
//        let inset: CGFloat = 16
//        flowLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
//        let totalWidth = UIScreen.main.bounds.width - 4*inset - spacing
//        flowLayout.itemSize = CGSize(width:totalWidth/2, height: 32)
//        flowLayout.minimumLineSpacing = spacing
//        flowLayout.minimumInteritemSpacing = spacing
//        flowLayout.scrollDirection = .vertical
//
//        sesacTitleCollectionView.collectionViewLayout = flowLayout
        
        
    }
}

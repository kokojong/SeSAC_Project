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
    
    let stackview = UIStackView()
    let titleContainerView = UIView()
    let sesacTitleLabel = UILabel()
    
    let reviewLabel = UILabel()
    let myReviewLabel = UILabel()
    
    //UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 5*16, height: 300)
//    let sesacTitleCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 5*16, height: 200), collectionViewLayout: UICollectionViewFlowLayout()).then{
    
    let sesacTitleCollectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        
        $0.register(SesacTitleCollectionViewCell.self, forCellWithReuseIdentifier: SesacTitleCollectionViewCell.identifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let inset: CGFloat = 0
        flowLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        let totalWidth = UIScreen.main.bounds.width - 4*inset - spacing
        flowLayout.itemSize = CGSize(width:totalWidth/2, height: 32)
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.scrollDirection = .vertical
        
        $0.collectionViewLayout = flowLayout
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
        setConstraints()
        configViews()
        sesacTitleCollectionView.delegate = self
        sesacTitleCollectionView.dataSource = self
        sesacTitleCollectionView.register(SesacTitleCollectionViewCell.self, forCellWithReuseIdentifier: SesacTitleCollectionViewCell.identifier)
        print(sesacTitleCollectionView.frame.height)
        
        
        titleContainerView.isUserInteractionEnabled = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        addSubview(nicknameLabel)
        addSubview(moreButton)
        addSubview(reviewLabel)
        addSubview(myReviewLabel)
        addSubview(stackview)
        stackview.addArrangedSubview(titleContainerView)
        titleContainerView.addSubview(sesacTitleLabel)
        titleContainerView.addSubview(sesacTitleCollectionView)
        
    }
    
    func setConstraints() {
        nicknameLabel.snp.makeConstraints { make in
//            make.top.leading.bottom.equalToSuperview().inset(16)
            make.top.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(moreButton.snp.leading).inset(16)
            
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        stackview.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(160)
        }
        
        
        sesacTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }

        sesacTitleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleLabel.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(stackview.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            
        }
        
        myReviewLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            
        }
    }
    
    func configViews() {
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.gray2?.cgColor
        self.layer.borderWidth = 1
        
        nicknameLabel.textColor = .black
        nicknameLabel.font = .Title1_M16
        nicknameLabel.backgroundColor = .yellow
        
        sesacTitleLabel.font = .Title6_R12
        sesacTitleLabel.textColor = .black
        sesacTitleLabel.text = "새싹 타이틀"
//        sesacTitleLabel.backgroundColor = .green
        
//        sesacTitleCollectionView.backgroundColor = .blue
        sesacTitleCollectionView.isScrollEnabled = false
        
        reviewLabel.text = "새싹 리뷰"
        reviewLabel.font = .Title6_R12
        
        myReviewLabel.text = "첫 리뷰를 기다리는 중이에요"
        myReviewLabel.font = .Body3_R14
        
        stackview.axis = .vertical
        stackview.distribution = .fill
 
        

        
        
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

extension OpenedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SesacTitleCollectionViewCell.identifier, for: indexPath) as? SesacTitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.button.setTitle("테스또", for: .normal)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let spacing: CGFloat = 8
        let inset: CGFloat = 16
        let totalWidth = UIScreen.main.bounds.width - 4*inset - spacing

        print(UIScreen.main.bounds.width)
        print(totalWidth)
        return CGSize(width: totalWidth/2, height: 32)
    }
    
    
    
}

class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
        
        
    }
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}

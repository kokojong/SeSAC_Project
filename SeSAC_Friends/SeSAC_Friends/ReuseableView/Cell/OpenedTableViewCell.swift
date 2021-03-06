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
    
    let reputationTags = ["좋은 매너", "정확한 시간 약속", "빠른 응답", "친절한 성격", "능숙한 취미 실력", "유익한 시간", "", "", ""]
    var reputationCount = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
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
        
        addViews()
        addConstraints()
        configViews()
        sesacTitleCollectionView.delegate = self
        sesacTitleCollectionView.dataSource = self
        sesacTitleCollectionView.register(SesacTitleCollectionViewCell.self, forCellWithReuseIdentifier: SesacTitleCollectionViewCell.identifier)

        
        titleContainerView.isUserInteractionEnabled = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(nicknameLabel)
        addSubview(moreButton)
        addSubview(reviewLabel)
        addSubview(myReviewLabel)
        addSubview(stackview)
        stackview.addArrangedSubview(titleContainerView)
        titleContainerView.addSubview(sesacTitleLabel)
        titleContainerView.addSubview(sesacTitleCollectionView)
        
    }
    
    func addConstraints() {
        nicknameLabel.snp.makeConstraints { make in
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
            
            // MARK: 임시로 160
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
//            make.height.equalTo(self.sesacTitleCollectionView.contentSize.height)
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
        
        sesacTitleLabel.font = .Title6_R12
        sesacTitleLabel.textColor = .black
        sesacTitleLabel.text = "새싹 타이틀"

        sesacTitleCollectionView.isScrollEnabled = false
        
        reviewLabel.text = "최근 리뷰"
        reviewLabel.font = .Title6_R12
        
        myReviewLabel.text = "첫 리뷰를 기다리는 중이에요"
        myReviewLabel.font = .Body3_R14
        myReviewLabel.textColor = .gray6
        myReviewLabel.numberOfLines = 0
        
        stackview.axis = .vertical
        stackview.distribution = .fill
        
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
        
        if reputationCount[indexPath.row] > 0 {
            cell.button.style = .fill
        }
        
        cell.button.setTitle(reputationTags[indexPath.row], for: .normal)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let spacing: CGFloat = 8
        let inset: CGFloat = 16
        let totalWidth = UIScreen.main.bounds.width - 4*inset - spacing

        return CGSize(width: totalWidth/2, height: 32)
    }
    
    
    
    
    
}


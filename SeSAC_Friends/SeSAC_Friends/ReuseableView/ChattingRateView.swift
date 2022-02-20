//
//  ChattingRateView.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/20.
//

import UIKit
import SnapKit
import Then

class ChattingRateView: UIView, UiViewProtocol {
    
    let titleLabel = UILabel().then {
        $0.font = .Title3_M14
        $0.textColor = .black
        $0.text = "titleLabel"
    }
    
    let cancelButton = UIButton().then {
        $0.setImage(UIImage(named: "close_small"), for: .normal)
    }
    
    let subtitleLabel = UILabel().then {
        $0.font = .Title4_R14
        $0.textColor = .green
        $0.text = "subtitleLabel"
    }
    
    // MARK: VC에서 flowlayout 정하기
    let rateTagCollectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let rateTextView = UITextView().then {
        $0.text = "rateTextView"
        $0.textColor = UIColor.lightGray
        $0.backgroundColor = .gray1
        $0.layer.cornerRadius = 8
    }
    
    let rateButton = MainButton(type: .disable).then {
        $0.setTitle("rateButton", for: .normal)
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 20
        
        addViews()
        addConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(titleLabel)
        addSubview(cancelButton)
        addSubview(subtitleLabel)
        addSubview(rateTagCollectionView)
        addSubview(rateTextView)
        addSubview(rateButton)
    }
    
    func addConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(21)
            make.size.equalTo(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        rateTagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(72) // 임시
        }
        
        rateTextView.snp.makeConstraints { make in
            make.top.equalTo(rateTagCollectionView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(125)
        }
        
        rateButton.snp.makeConstraints { make in
            make.top.equalTo(rateTextView.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(48)
            
        }
    }

}

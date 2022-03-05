//
//  FaceCollectionViewCell.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/03/05.
//

import UIKit
import SnapKit
import Then

class FaceCollectionViewCell: UICollectionViewCell, CellReusable, UiViewProtocol {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let faceImageView = UIImageView().then {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray2?.cgColor
    }
    
    let titleView = UIView()
    let titleLabel = UILabel().then {
        $0.font = .Title3_M14
        $0.textColor = .black
    }
    let subtitleLabel = UILabel().then {
        $0.font = .Body3_R14
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    let priceButton = MainButton(type: .fill).then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.setTitle("1,200", for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(faceImageView)
        addSubview(titleView)
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        titleView.addSubview(priceButton)
    }
    
    func addConstraints() {
        faceImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(faceImageView.snp.width)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(faceImageView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(priceButton.snp.leading).offset(-8)
        }
        
        priceButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.equalTo(52)
            make.height.equalTo(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
            
        }
    }
    
}

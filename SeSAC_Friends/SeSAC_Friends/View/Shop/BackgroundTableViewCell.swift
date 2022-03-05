//
//  BackgroundTableViewCell.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/03/05.
//

import UIKit
import SnapKit
import Then


class BackgroundTableViewCell: UITableViewCell, CellReusable, UiViewProtocol {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let backgroundImageView = UIImageView().then {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(backgroundImageView)
        addSubview(titleView)
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        titleView.addSubview(priceButton)
    }
    
    func addConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(titleView)
            make.height.equalTo(backgroundImageView.snp.width)
            
        }
        
        titleView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(backgroundImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(80)
            
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


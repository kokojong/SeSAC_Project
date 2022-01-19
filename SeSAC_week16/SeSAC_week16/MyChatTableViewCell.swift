//
//  MyChatTableViewCell.swift
//  SeSAC_week16
//
//  Created by kokojong on 2022/01/13.
//

import UIKit
import SnapKit

class MyChatTableViewCell: UITableViewCell {
    
    static let identifier = "MyChatTableViewCell"
    
    var containerView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .yellow
        
        return view
    }()
    
    var chatLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .gray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addViews() {
        addSubview(containerView)
        addSubview(chatLabel)

    }
    
    func setConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.width / 2)
        }
        
        chatLabel.snp.makeConstraints { make in
            make.edges.equalTo(containerView).inset(16)
        }
        
    }
    
}

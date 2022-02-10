//
//  SearchView.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/08.
//

import UIKit
import SnapKit
import Then

class SearchView: UIView, UiViewProtocol {
    
    let glassView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = .systemGray
    }
    
    let textField = UITextField().then {
        $0.tintColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray1
        addViews()
        addConstraints()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(glassView)
        addSubview(textField)
    }
    
    func addConstraints() {
        glassView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(8)
            make.size.equalTo(16)
            
        }
        
        textField.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(glassView.snp.trailing).offset(8)
        }
    }
    
    
    
}

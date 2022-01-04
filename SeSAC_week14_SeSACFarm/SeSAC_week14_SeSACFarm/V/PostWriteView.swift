//
//  PostWriteView.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/04.
//

import UIKit

class PostWriteView: UIView {

    var textView: UITextView = {
        let textview = UITextView()
        textview.font = .systemFont(ofSize: 15)
        return textview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupView() {
        addSubview(textView)
        
    }
    
    func setupConstraints() {
        textView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
}

//
//  SquareBoxView.swift
//  SeSAC_week12
//
//  Created by kokojong on 2021/12/13.
//

import UIKit

class SquareBoxView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadView()
        loadUI()
    }
    
    
    func loadView() {
        // 다른 방식(이거보다 아래 방식이 더 자주 사용)
//        let view2 = Bundle.main.loadNibNamed("SquareBoxView", owner: self, options: nil)?.first as! UIView
        
        let view = UINib(nibName: "SquareBoxView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        self.addSubview(view)
        
        
    }
    
    func loadUI() {
        label.font = .boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.text = "마이페이지"
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .black
    }
    
}

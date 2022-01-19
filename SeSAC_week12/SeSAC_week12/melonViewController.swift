//
//  melonViewController.swift
//  SeSAC_week12
//
//  Created by kokojong on 2021/12/15.
//

import UIKit
import SnapKit

class melonViewController: UIViewController {
    
    let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "무야호")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        
        view.addSubview(albumCoverImageView)
        
        albumCoverImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self.view)
            // 아래처럼 했더니 오류가 났다
            // make.height.equalTo(make.width)

            // 글을 작성하면서 생각한대로 했더니 된다 뭐지...? 처음에 make.width는 자세히 살펴보니 make가 ConstraintMaker였다.. 난 바보다
            make.height.equalTo(albumCoverImageView.snp.width)

            // 억지로 똑같이 맞췄었다...
            //make.width.equalTo(view.snp.width).multipliedBy(0.5)
        }
        
        
        
        
    }
    


}

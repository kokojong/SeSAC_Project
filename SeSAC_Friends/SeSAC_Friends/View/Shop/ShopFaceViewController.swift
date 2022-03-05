//
//  ShopFaceViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/03/05.
//

import UIKit

class ShopFaceViewController: UIViewController {
    
    let mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .magenta
        
        addViews()
        addConstraints()
        
    }
    
    func addViews() {
        view.addSubview(mainCollectionView)
        
    }
    
    func addConstraints(){
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(235) // ProfileBackgroundView의 높이 + inset
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
    }
    
    
    
    


}

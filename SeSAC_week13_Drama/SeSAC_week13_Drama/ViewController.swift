//
//  ViewController.swift
//  SeSAC_week13_Drama
//
//  Created by kokojong on 2021/12/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

//    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10

        layout.scrollDirection = .vertical // 가로로 먼저 쌓이게 함
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return cv
    }()
    
    let searchTextField = UISearchTextField()
    
    let testLabel = UILabel()
    
    var spacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(searchTextField)
        setSearchTextField()
        
        view.addSubview(collectionView)
        setCollectionView()
        
       
        
        view.addSubview(testLabel)
        testLabel.snp.makeConstraints { make in
            testLabel.text = "test"
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
    
        
        
    }
    
    func setCollectionView() {
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        collectionView.backgroundColor = .blue
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.reloadData()
        
    }

    func setSearchTextField() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(collectionView.snp.top)
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.titleLabel?.text = "test"
        cell.backgroundColor = .yellow
        return cell
    }
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.frame.width
        let totalHeight = collectionView.frame.height
        
        let cellWidth = (totalWidth - spacing*5)/3
        let cellHeight = (totalHeight - spacing*5)/4
        
//        print(totalWidth, cellWidth)
//        print(UIScreen.main.bounds.width)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//           return spacing
//    }
    
    
    
}


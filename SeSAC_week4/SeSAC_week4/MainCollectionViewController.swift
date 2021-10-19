//
//  MainCollectionViewController.swift
//  SeSAC_week4
//
//  Created by kokojong on 2021/10/19.
//

import UIKit
import Toast
// tableView -> CollectionView
// row -> item
class MainCollectionViewController: UIViewController {

    // 1. collectionView 아웃렛 연결
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    var mainArray = Array(repeating: false, count: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainCollectionView.tag = 100
        tagCollectionView.tag = 200
  
        // 3. Delegate
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        
        
        // 4. XIB
        let nibName = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        mainCollectionView.register(nibName, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        
        mainCollectionView.collectionViewLayout = layout
        mainCollectionView.backgroundColor = .gray
        
        
        // tagCollectionView
        let tagNibName = UINib(nibName: TagCollectionViewCell.identifier, bundle: nil)
        tagCollectionView.register(tagNibName, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        
        let tagLayout = UICollectionViewFlowLayout()
        let tagSpacing : CGFloat = 8
        tagLayout.scrollDirection = .horizontal
        tagLayout.itemSize = CGSize(width: 100, height: 40)
        tagLayout.minimumInteritemSpacing = tagSpacing
        tagLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        tagCollectionView.collectionViewLayout = tagLayout
        
        
    }
    
    @objc func heartButtonClicked(selectButton : UIButton) {
        print("\(selectButton.tag) 버튼 클릭!")
        mainArray[selectButton.tag] = !mainArray[selectButton.tag]
//        mainCollectionView.reloadData() // 필수! (전체)
        mainCollectionView.reloadItems(at: [ IndexPath(item: selectButton.tag, section: 0) ] ) // 특정한 아이템만 리로드해줌
        
        self.view.makeToast("하트 버튼 클릭!")
    }

   

}

// 2. Collectionview Protocol
extension MainCollectionViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollectionView {
            return 10
        } else {
            return mainArray.count
        }
        
        // 다른 방법
        if collectionView.tag == 200 {
            
        } else {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == tagCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else {
                return UICollectionViewCell()
            }
            
    //        list[indexPath.item] row가 item으로
            
            cell.tagLabel.text = "하이욤"
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 5
            
            return cell
            
        } else {
         
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
                return UICollectionViewCell()
            }
            
    //        list[indexPath.item] row가 item으로
            
            let item = mainArray[indexPath.item] // 몇번째인지
            
            cell.mainImageView.backgroundColor = .blue
            let image = item ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            cell.heartButton.setImage(image, for: .normal)
            cell.heartButton.tag = indexPath.item
            cell.heartButton.addTarget(self, action: #selector(heartButtonClicked(selectButton: )), for: .touchUpInside)
            
            return cell
            
        }
        
       
        
    }
    
    
    
}

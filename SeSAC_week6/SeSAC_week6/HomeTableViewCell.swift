//
//  HomeTableViewCell.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/08.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identiifer = "HomeTableViewCell"
    
    var data: [String] = []  {// array[indexPath.row]
        didSet{
            collectionVIew.reloadData()
            categoryLabel.text = "\(data.count)개"
        }
    }
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var collectionVIew: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionVIew.delegate = self
        collectionVIew.dataSource = self
        collectionVIew.isPagingEnabled = true
        
        categoryLabel.backgroundColor = .blue
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        if collectionView.tag == 0 {
            cell.imageView.backgroundColor = .brown
        } else {
            cell.imageView.backgroundColor = .magenta
        }
        
        cell.contentLabel.text = data[indexPath.item] // row도 맞지만 의미상 item을 사용
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 테이블 뷰 셀의 인덱스 패스를 어떻게 가지고 와야할까?
        if collectionView.tag == 0{
            return CGSize(width: UIScreen.main.bounds.width, height: 100)
        } else {
            return CGSize(width: 150, height: 100)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView.tag == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.tag == 0 ? 0 : 10
        
    }
    
    
    

}


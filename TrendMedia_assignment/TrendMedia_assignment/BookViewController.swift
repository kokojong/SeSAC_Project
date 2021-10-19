//
//  BookViewController.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/19.
//

import UIKit
import Kingfisher

class BookViewController: UIViewController {

    @IBOutlet weak var bookCollectionView: UICollectionView!
    
    static let identifier = "BookViewController"
    
    var bookTvshowList = TvshowList() // 전체 리스트
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let nibName = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        bookCollectionView.register(nibName, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
   
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 3) // spacing을 뺀 가로
        layout.itemSize = CGSize(width: width / 2, height: (width / 2)) // cell의 사이즈
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing) // 컬렉션뷰를 보여줄 영역(패딩)
        layout.minimumInteritemSpacing = spacing // 너비
        layout.minimumLineSpacing = spacing // 높이
        layout.scrollDirection = .vertical
    
        
        bookCollectionView.collectionViewLayout = layout
        bookCollectionView.backgroundColor = .gray
        
    }
    

    

}

extension BookViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookTvshowList.tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }

        let row = bookTvshowList.tvShow[indexPath.row]
        cell.rateLabel.text = "\(row.rate)"
        cell.titleLabel.text = row.title
        let url = URL(string: row.backdropImage)
        cell.bookImageView.kf.setImage(with: url)
        
        cell.backgroundColor = .blue
        cell.layer.cornerRadius = 8
        
        
        
        return cell
        
    }
    
    
}

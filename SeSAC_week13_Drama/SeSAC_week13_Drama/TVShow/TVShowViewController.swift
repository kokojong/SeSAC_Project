//
//  TVShowViewController.swift
//  SeSAC_week13_Drama
//
//  Created by kokojong on 2021/12/29.
//

import UIKit

class TVShowViewController: UIViewController {

    let viewModel = TVShowViewModel()
    
    let mainView = TVShowView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        mainView.searchTextField.addTarget(self, action: #selector(searchTextFieldDidChange(_:)), for: .editingChanged)
        
        
        viewModel.searchedTVShow.bind { tvshow in
            
        }
    }
    
    @objc func searchTextFieldDidChange(_ searchTextField: UISearchTextField) {
        viewModel.searchTVShow(searhText: searchTextField.text ?? "")
    }
   
    
}

extension TVShowViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TVShowCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .orange
        let row = viewModel.cellForItemAt(indexPath: indexPath)
        
        return cell
    }
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 10
        let totalWidth = collectionView.frame.width
        let totalHeight = collectionView.frame.height
        
        let cellWidth = floor((totalWidth - spacing*4)/3)
        let cellHeight = (totalHeight - spacing*5)/4
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
}

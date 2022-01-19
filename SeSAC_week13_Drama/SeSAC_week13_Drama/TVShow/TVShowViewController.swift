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
        mainView.collectionView.register(TVShowCollectionViewCell.self, forCellWithReuseIdentifier: TVShowCollectionViewCell.identifier)
        
        viewModel.searchTVShow(searhText: mainView.searchTextField.text!)
        viewModel.searchedTVShow.bind { tvshow in
            self.mainView.collectionView.reloadData()
        }
    }
    
    @objc func searchTextFieldDidChange(_ searchTextField: UISearchTextField) {
        print("searchTextField", searchTextField.text)
        viewModel.searchTVShow(searhText: searchTextField.text ?? "")
//        mainView.collectionView.reloadData()
    }
   
    
}

extension TVShowViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("viewModel.numberOfItemsInSection", viewModel.numberOfItemsInSection)
        return viewModel.numberOfItemsInSection

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCollectionViewCell.identifier, for: indexPath) as? TVShowCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let row = viewModel.cellForItemAt(indexPath: indexPath)
    
        let url = URL(string: "https://image.tmdb.org/t/p/original" + row.posterPath)
//        let url = Endpoint.searchTVShow(key: APIService.APIKEY, query: mainView.searchTextField.text!).url
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.posterImageView.image = UIImage(data: data!)
            }
        }
        
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

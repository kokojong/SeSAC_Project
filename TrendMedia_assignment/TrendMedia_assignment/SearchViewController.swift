//
//  SearchViewController.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/16.
//

import UIKit

class SearchViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var searchedTvshow = TvshowList()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedTvshow.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else { return UITableViewCell() }
        
        let row = searchedTvshow.tvShow[indexPath.row]
        
        cell.titleLabel.text = row.title
        cell.releaseDateLabel.text = row.releaseDate
        cell.overviewLable.text = row.overview
        
        let url = URL(string: row.backdropImage)
        let data = try? Data(contentsOf: url!)
        cell.posterImageView.image = UIImage(data: data!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        
        
        // 임베드 된 nav에서 동작을 구현(스토리보드 상에는 임베드 되지 않음)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action:#selector(closeButtonClicked) )
      
    }
    
    @objc func closeButtonClicked () {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

    

}

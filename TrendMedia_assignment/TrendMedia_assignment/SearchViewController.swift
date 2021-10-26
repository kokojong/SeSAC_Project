//
//  SearchViewController.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/16.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SearchViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var searchedTvshow = TvshowList()
    
    var movieData: [MovieModel] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        fetchMovieData()
        
        // 임베드 된 nav에서 동작을 구현(스토리보드 상에는 임베드 되지 않음)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action:#selector(closeButtonClicked) )
      
    }
    
    @objc func closeButtonClicked () {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else {
            return UITableViewCell() }
            
//            let row = searchedTvshow.tvShow[indexPath.row]
//
//            cell.titleLabel.text = row.title
//            cell.releaseDateLabel.text = row.releaseDate
//            cell.overviewLable.text = row.overview
//
//            let url = URL(string: row.backdropImage)
//            let data = try? Data(contentsOf: url!)
//            cell.posterImageView.image = UIImage(data: data!)
            
        let row = movieData[indexPath.row]
        cell.titleLabel.text = row.titleData
        cell.overviewLable.text = row.subtitle
        
        let url = URL(string: row.imageData)
        cell.posterImageView.kf.setImage(with: url,placeholder: UIImage(systemName: "person"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // 네이버 영화 네트워크 통신
    func fetchMovieData() {
        
        if let query = "스파이더맨".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=15&start=1"
            let headers : HTTPHeaders = [
                "X-Naver-Client-Id": "sHXg6cdzeK4giS0SuZA2",
                "X-Naver-Client-Secret": "yrsXMsOkxI"
            ]
            
            AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
//                    let title = json["items"][0]["title"].stringValue
//                    print(title)
                    
                    for item in json["items"].arrayValue {
                        let title = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                        let image = item["image"].stringValue
                        let link = item["link"].stringValue
                        let userRating = item["userRating"].stringValue
                        let subtitle = item["subtitle"].stringValue
                        
                        let data = MovieModel(titleData: title, imageData: image, linkData: link, userRatingData: userRating, subtitle: subtitle)
                        self.movieData.append(data)
                        
                    }
                    
                    print(self.movieData)
                    
                    self.searchTableView.reloadData()
//
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        
        
    }
    

}

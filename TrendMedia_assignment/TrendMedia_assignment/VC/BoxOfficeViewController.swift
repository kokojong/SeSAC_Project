//
//  BoxOfficeViewController.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON
import Network

class BoxOfficeViewController: UIViewController {
    
    static let identifier = "BoxOfficeViewController"

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var boxOfficeTableView: UITableView!
    
    var boxOfficeList: [BoxOfficeModel] = []
    
    var searchDate: String = "20211025"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        boxOfficeTableView.delegate = self
        boxOfficeTableView.dataSource = self
        
        loadBoxOfficeData()
        
        networkMonitor()
        
    }
    
 

    @IBAction func onSearchButtonClicked(_ sender: UIButton) {
    
        guard let keyword = searchTextField.text else {
            return
        }
        
        searchDate = keyword
        loadBoxOfficeData()
    
    }
    

}



extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier) as? BoxOfficeTableViewCell else { return UITableViewCell() }
        
        let row = boxOfficeList[indexPath.row]
        
        cell.movieRankLabel.text = row.rank
        cell.movieTitleLabel.text = row.title
        cell.movieReleaseDateLabel.text = row.releaseDate
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func loadBoxOfficeData() {
        
        boxOfficeList = [] // 다른 날짜를 입력할 때 초기화
        
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=\(searchDate)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let rank = movie["rank"].stringValue
                    let title = movie["movieNm"].stringValue
                    let releaseDate = movie["openDt"].stringValue
                    
                    let data = BoxOfficeModel(rank: rank, title: title, releaseDate: releaseDate)
                    self.boxOfficeList.append(data)
                    
                }
                
                // 데이터가 변했으니까 꼭! 해주기
                self.boxOfficeTableView.reloadData()
                
                
            case .failure(let error):
                print(error)
            }
        }

        
    }
    
    
}

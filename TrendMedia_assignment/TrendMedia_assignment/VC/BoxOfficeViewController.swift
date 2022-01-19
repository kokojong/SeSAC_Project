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
import RealmSwift


class BoxOfficeViewController: UIViewController {
    
    static let identifier = "BoxOfficeViewController"

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var boxOfficeTableView: UITableView!
    
    var boxOfficeList: [BoxOfficeModel] = []
    
    var defalutDate: String = "20211025" // 디폴트값
    
    var taskList: Results<BoxOfficeList>! // 전체 tasklist
    
    var filteredList: Results<BoxOfficeList>! // 필터링 된 tasklist
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        boxOfficeTableView.delegate = self
        boxOfficeTableView.dataSource = self
        
        networkMonitor()
        
        print("Realm:",localRealm.configuration.fileURL!) // 경로 찾기
        
        taskList = localRealm.objects(BoxOfficeList.self)
        
        
        
        let predicate = NSPredicate(format: "dateString == %@",defalutDate)

//        print("predicate: ",taskList.filter(predicate))
        
        if taskList.filter(predicate).count == 0 { // 이 날짜로 저장된 realm이 없다면?
            // 검색해서 데이터를 불러오고 -> 이걸 realm에 저장해주기
            loadBoxOfficeData(searchDate: defalutDate)
            print("처음 킨 거: ",boxOfficeList)
            
            
        } else { // 이 날짜로 저장된 realm이 있다면 -> 불러오기
            
            let filter = taskList.filter(predicate)
            filteredList = filter
            print("20211025의 데이터가 있는경우: ", filter)
            
            boxOfficeList = []
            
            for i in 0...9 {
                let title = filteredList.first?.titleList[i]
                let releaseDate = filteredList.first?.releaseDateList[i]
                let data = BoxOfficeModel(title: title!, releaseDate: releaseDate!)
                
                boxOfficeList.append(data)
            }
            
            boxOfficeTableView.reloadData()
        
        }
        
    }
    
 

    @IBAction func onSearchButtonClicked(_ sender: UIButton) {
    
        guard let keyword = searchTextField.text else {
            return
        }
        
        let predicate = NSPredicate(format: "dateString == %@",keyword)
//        NSPredicate(format: "%K > %@ AND %K == %@", "progressMinutes", NSNumber(1), "name", "Ali")

        if taskList.filter(predicate).count == 0 { // 이 날짜로 저장된 realm이 없다면?
            // 검색해서 데이터를 불러오고 -> 이걸 realm에 저장해주기
            loadBoxOfficeData(searchDate: keyword)
            
            
        } else { // 이 날짜로 저장된 realm이 있다면 -> 불러오기
            
            let filter = taskList.filter(predicate)
            filteredList = filter
            print("searchButton filter", filter)
            
            boxOfficeList = []
            print("before",boxOfficeList)
            
            for i in 0...9 {
                // 이부분에서 taskList.first로 했더니 taskList가 초기화 되면서 오류가 있었다.
                let title = filteredList.first?.titleList[i]
                let releaseDate = filteredList.first?.releaseDateList[i]
                let data = BoxOfficeModel(title: title!, releaseDate: releaseDate!)
                
                boxOfficeList.append(data)
                
            }
            print("after",boxOfficeList)
            boxOfficeTableView.reloadData()
            
        }
        
    }
    
    func saveRealm(list: [BoxOfficeModel], searchDate: String) {
        
        var titleList: [String] = []
        var releaseDateList: [String] = []
        for i in (0...9){
            titleList.append(list[i].title)
            releaseDateList.append(list[i].releaseDate)
        }

        let task = BoxOfficeList(dateString: searchDate, titleArray: titleList, releaseDateArray: releaseDateList)

        print("saveRealm task",task)
//        print(task.titleList[0])
        try! localRealm.write {
            localRealm.add(task)
        }
        
        self.boxOfficeTableView.reloadData()
        
    }
    

}


extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier) as? BoxOfficeTableViewCell else { return UITableViewCell() }
        
        let row = boxOfficeList[indexPath.row]
        
        cell.movieRankLabel.text = "\(indexPath.row + 1)"
        cell.movieTitleLabel.text = row.title
        cell.movieReleaseDateLabel.text = row.releaseDate
//        cell.movieTitleLabel.text = taskList
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func loadBoxOfficeData(searchDate: String) {
        
        boxOfficeList = [] // 다른 날짜를 입력할 때 초기화
        
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=\(searchDate)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
//                    let rank = movie["rank"].stringValue
                    let title = movie["movieNm"].stringValue
                    let releaseDate = movie["openDt"].stringValue
                    
                    let data = BoxOfficeModel(title: title, releaseDate: releaseDate)
                    self.boxOfficeList.append(data)
                    
                }
//                print("boxOfficeList2: ",self.boxOfficeList)
                
                self.saveRealm(list: self.boxOfficeList, searchDate: searchDate)
                // 데이터가 변했으니까 꼭! 해주기
                self.boxOfficeTableView.reloadData()
                
                
            case .failure(let error):
                print(error)
            }
        }

        
    }
    
    
}

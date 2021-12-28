//
//  ViewController.swift
//  SeSAC_week13
//
//  Created by kokojong on 2021/12/21.
//

import UIKit
import SnapKit

enum APIError: String, Error {
    case unknownError = "alert_error_unknown"
    case serverError = "alert_error_server"
}

extension APIError: LocalizedError { // 다국어 처리
    var errorDescription: String? {
//        switch self {
//        case .unknownError:
//            return NSLocalizedString(self.rawValue, comment: "")
//        case .serverError:
//            return NSLocalizedString(self.rawValue, comment: "")
//        } // -> switch 없이 그냥 한줄로 표시가 가능
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
}

class ViewController: UIViewController {
    
    var tableView = UITableView()
    
    var apiService = APIService()

    var castData: Cast? // 배열이어야 하는게 아닐까? (Cast를 잘 보면 내부에 배열이 존재함 -> 그걸 이용하고자 한거니까 Cast는 전체?데이터)
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier) // 더 편해짐
        print(Thread.isMainThread) // 메인 쓰레드
        
        apiService.requestCast { cast in
            self.castData = cast
            print(Thread.isMainThread) // 여기는 메인 쓰레드가 아님
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castData?.peopleListResult.peopleList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value2, reuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier) // 편해져따
        cell?.textLabel?.text = castData?.peopleListResult.peopleList[indexPath.row].peopleNm
        cell?.detailTextLabel?.text = "detail"
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//class testCell: UITableViewCell {
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//
//    }
//}

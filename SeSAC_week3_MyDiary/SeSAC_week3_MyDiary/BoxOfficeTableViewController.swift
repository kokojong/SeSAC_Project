//
//  BoxOfficeTableViewController.swift
//  SeSAC_week3_MyDiary
//
//  Created by kokojong on 2021/10/13.
//

import UIKit

class BoxOfficeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 타입 캐스팅
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BoxOfficeTableViewCell", for: indexPath) as? BoxOfficeTableViewCell else {
            return UITableViewCell() // 빈 인스턴스 전달
        }
        
        cell.posterImageVIew.backgroundColor = .red
        cell.titleLable.text = "7번방의 선물"
        cell.releaseLabel.text = "2021.01.01"
        cell.overviewLabel.text = "영화 줄거리가 보인다.영화 줄거리가 보인다.영화 줄거리가 보인다.영화 줄거리가 보인다.영화 줄거리가 보인다.영화 줄거리가 보인다.영화 줄거리가 보인다.영화 줄거리가 보인다.영화 줄거리가 보인다.영화 줄거리가 보인다."
        cell.overviewLabel.numberOfLines = 0
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }

    
   
}

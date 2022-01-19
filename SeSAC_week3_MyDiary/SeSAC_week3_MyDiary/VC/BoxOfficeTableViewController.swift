//
//  BoxOfficeTableViewController.swift
//  SeSAC_week3_MyDiary
//
//  Created by kokojong on 2021/10/13.
//

import UIKit

class BoxOfficeTableViewController: UITableViewController {
    
    // Pass Data
    // 1. 값을 전달받을 공간, type 명시
    var titleSpace : String?
    
    let movieInfo = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2. 표현
        title = titleSpace ?? "내용이 없을 때 타이틀"
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonClicked))

        
    }
    
    // IBAction연결
    @objc func closeButtonClicked() {
        // push - pop
        
        self.navigationController?.popViewController(animated: true)
        // 기존의 백버튼을 덮어써서 스크린 엣지 기능은 사라진다.
        
        // push : dimisss X, present : pop X (짝을 잘 맞춰서 써야한다)
        // 사용에 유의하기
//        self.dismiss(animated: true, completion: nil)
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movieInfo.movie.count // 영화의 갯수
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 타입 캐스팅
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as? BoxOfficeTableViewCell else {
            return UITableViewCell() // 빈 인스턴스 전달
        }
        
        let row = movieInfo.movie[indexPath.row] // 이렇게 축약해서 사용가능
        // keyword, 예약어
        let `switch` = movieInfo.movie[indexPath.row] // 이런식으로 예약어를 사용가능함(자주 사용하지x)
        
        cell.posterImageVIew.backgroundColor = .red
        cell.posterImageVIew.image = UIImage()
        cell.titleLable.text = row.title
        cell.releaseLabel.text = row.releaseDate
        cell.overviewLabel.text = row.overview
        cell.overviewLabel.numberOfLines = 0
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Movie", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "BoxOfficeDetailViewController") as? BoxOfficeDetailViewController else {
            print("Error")
            return
        }
        
        let row = movieInfo.movie[indexPath.row]
        
        // pass data3
//        vc.releaseDate = row.releaseDate
//        vc.overview = row.overview
//        vc.rate = row.rate
//        vc.movieTitle = row.title
//        vc.runtime = row.runtime
        vc.movieData = row
        
//        let vc = sb.instantiateViewController(withIdentifier: "BoxOfficeDetailViewController") as! BoxOfficeDetailViewController
//
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
   
}

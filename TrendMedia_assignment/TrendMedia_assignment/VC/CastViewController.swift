//
//  CastViewController.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/16.
//

import UIKit
import Kingfisher

class CastViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    // pass data 1. 받을 공간 만들기
    var tvshowData : TvShow?
    
    // new pass data
    var trendMediaTVData : TrendMediaTVModel?
    
    var castList: [CastModel] = []
    var crewList : [CrewModel] = []
   
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var castTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        castTableView.delegate = self
        castTableView.dataSource = self
        
        castTableView.estimatedRowHeight = 100
        castTableView.rowHeight = UITableView.automaticDimension
        
        // pass data 2. 받은 데이터로 뭘할지 정하기
        titleLabel.textColor = .white
        titleLabel.text = trendMediaTVData?.original_name
        
        
        // 기본적인 방법으로 URL -> Image
//        let url = URL(string: tvshowData?.backdropImage ?? "")
//        let data = try? Data(contentsOf: url!)
//        backgroundImageView.image = UIImage(data: data!)
//        posterImageView.image = UIImage(data: data!)
        
        // kingfisher를 사용한 버전
//        let url = URL(string: EndPoint.TMDB_POSETER_URL + row.poster_path)
//
//        cell.posterImageView.kf.setImage(with: url)
        
        let posterUrl = URL(string: EndPoint.TMDB_POSETER_URL + trendMediaTVData!.poster_path)
        posterImageView.kf.setImage(with: posterUrl)
        let backdropUrl = URL(string: EndPoint.TMDB_POSETER_URL + trendMediaTVData!.backdrop_path)
        backgroundImageView.kf.setImage(with: backdropUrl)
        
        // 뒤로가기 버튼을 커스텀(주석 부분은 실패)
//        navigationController?.popViewController(animated: true)
//        navigationItem.backButtonTitle = "뒤로가기"
        navigationItem.title = "출연/제작"
        
        // overviewCell

        
        loadCreditsData()
        
        
        
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return castList.count
        case 2: return crewList.count
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell() }
            
            print(cell.overviewButton.tag)
            if cell.overviewButton.tag == 0 {
                cell.overviewLabel.numberOfLines = 1
            } else {
                cell.overviewLabel.numberOfLines = 0
            }
            
            cell.overviewLabel.text = trendMediaTVData?.overview
            
            cell.overviewButton.addTarget(self, action: #selector(overviewButtonClicked(overviewButton: )), for: .touchUpInside)
            
            return cell
            
        } else if indexPath.section == 1 {
            
            guard let cell = castTableView.dequeueReusableCell(withIdentifier: "CastTableViewCell") as? CastTableViewCell else {
                return UITableViewCell()
            }
            
            let row = castList[indexPath.row]
            let url = URL(string: EndPoint.TMDB_POSETER_URL + row.profile_path)
            
            cell.castImageView.kf.setImage(with: url,placeholder: UIImage(systemName: "person"))
            cell.nameLabel.text = row.name
            cell.roleLabel.text = row.character
            
            return cell
            
        } else {
            
            guard let cell = castTableView.dequeueReusableCell(withIdentifier: CrewTableViewCell.identifier) as? CrewTableViewCell else { return UITableViewCell() }
            
            let row = crewList[indexPath.row]
            let url = URL(string: EndPoint.TMDB_POSETER_URL + row.profile_path)
            
            cell.crewImageView.kf.setImage(with: url,placeholder: UIImage(systemName: "person"))
            cell.nameLabel.text = row.name
            cell.roleLabel.text = row.department
            
            return cell
            
        }
    
        
    }
    
    @objc func overviewButtonClicked(overviewButton : UIButton) {
        if overviewButton.image(for: .normal) ==
            UIImage(systemName: "arrow.down") {
            overviewButton.setImage(UIImage(systemName: "arrow.up"), for: .normal)
            overviewButton.tag = 1 // on
            castTableView.reloadData()
            // reloadRows는 왜 안되는지 모르겠다..
//            castTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            self.castTableView.rowHeight = UITableView.automaticDimension
            print("button \(overviewButton.tag)")
            
        } else {
            overviewButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
            overviewButton.tag = 0 // off
            castTableView.reloadData()
//            castTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            print("button \(overviewButton.tag)")
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "출연"
        } else if section == 2 {
            return "제작"
        } else {
            return ""
        }
    }

    func loadCreditsData() {
        
        TrendMediaCreditsAPIManager.shared.fetchTrendMediaCreditsData(movie_id: trendMediaTVData!.id) { json in
            
            for cast in json["cast"].arrayValue {
                let name = cast["name"].stringValue
                let character = cast["character"].stringValue
                let profile_path = cast["profile_path"].stringValue
                
                let data = CastModel(name: name, character: character, profile_path: profile_path)
                self.castList.append(data)
                
            }
            
            for crew in json["crew"].arrayValue {
                let name = crew["name"].stringValue
                let department = crew["department"].stringValue
                let profile_path = crew["profile_path"].stringValue
                
                let data = CrewModel(name: name, department: department, profile_path: profile_path)
                self.crewList.append(data)
            }
            
            self.castTableView.reloadData()
            
        }
        
    }
}

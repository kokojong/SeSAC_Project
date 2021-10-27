//
//  ViewController.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/15.
//

import UIKit

class TvshowListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    
    
    let tvshowList = TvshowList() // 구조체를 가져옴
    
    var indexPathRow = 0
    
    var trendMediaTVList: [TrendMediaTVModel] = []
    
    var pageNum = 1
    
    let totalPageCount = 1000 // api에서 정해짐
    
    @IBOutlet weak var tvshowTableView: UITableView!
    @IBOutlet weak var topButtonsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        topButtonsView.layer.borderColor = UIColor.gray.cgColor
        topButtonsView.layer.borderWidth = 1
        topButtonsView.layer.cornerRadius = 5
        
        // 프로토콜을 부를때 명시안해주면 목록을 못불러오는 경우가 있다(이거로 삽질을 좀 했다
        tvshowTableView.delegate = self
        tvshowTableView.dataSource = self
        tvshowTableView.estimatedRowHeight = 370
        tvshowTableView.rowHeight = UITableView.automaticDimension
        
        self.title = "TREND MEDIA"
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "magnifyingglass")
        
        self.navigationItem.leftBarButtonItem?.image = UIImage(systemName: "paperplane")
        
        let backBarButtonItem = UIBarButtonItem(title: "뒤뒤", style: .plain, target: self, action: #selector(onBackBarButtonClicked))
        
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        tvshowTableView.prefetchDataSource = self
        
        loadTvshowData()
        
    }
    
    @objc func onBackBarButtonClicked () {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func leftBarButtonClicked(_ sender: UIBarButtonItem) {
    
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "TheaterViewController") as! TheaterViewController
        
        vc.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    @IBAction func rightBarButtonClicked(_ sender: UIBarButtonItem) {
    
        // 1. sb
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. vc
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        // 2-1 navController embed
        let nav = UINavigationController(rootViewController: vc)
        
        // 2-2. present 방식(fullscreen)
        nav.modalPresentationStyle = .fullScreen
        
        // 3. present
        present(nav, animated: true, completion: nil)
    }
    

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if trendMediaTVList.count - 1 == indexPath.row && trendMediaTVList.count < totalPageCount { // 마지막에 도달하면
                pageNum += 1
                loadTvshowData()
                print("prefetch: \(indexPath)")
            }
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tvshowList.tvShow.count
        return trendMediaTVList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TvShowTableViewCell") as? TvShowTableViewCell else {
            return UITableViewCell()
        }
        

        let row = trendMediaTVList[indexPath.row]
        
        cell.titleLabel.text = row.original_name
        cell.rateLabel.text = "\(row.vote_average)"

        let url = URL(string: EndPoint.TMDB_POSETER_URL + row.poster_path)

        cell.posterImageView.kf.setImage(with: url)

//        let row = tvshowList.tvShow[indexPath.row] // 몇번째 요소인지 특정
        // data 삽입
//        cell.genreLabel.text = row.genre
//        cell.titleLabel.text = row.title
//        cell.rateLabel.text = "\(row.rate)"
//
//        let url = URL(string: row.backdropImage)
//        let data = try? Data(contentsOf: url!)
//        cell.posterImageView.image = UIImage(data: data!)
        
        // UI 꾸미기
        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        
        cell.genreLabel.textColor = .gray
        cell.genreLabel.font = .systemFont(ofSize: 13)
        
        cell.titleLabel.font = .boldSystemFont(ofSize: 20)
        cell.rateLabel.font = .systemFont(ofSize: 15)
        
        
        indexPathRow = indexPath.row
        print("\(indexPathRow)")
        
        cell.linkButton.addTarget(self, action: #selector(linkButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func linkButtonClicked() {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController

        vc.tvShowData = tvshowList.tvShow[indexPathRow]
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .automatic
        
        present(nav, animated: true, completion: nil)
        
    }
    
    // go to CastVC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 1. sb
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. vc
        guard let vc = sb.instantiateViewController(withIdentifier: "CastViewController") as? CastViewController else { return }
        
        
        // pass data
        let row = tvshowList.tvShow[indexPath.row]
        vc.tvshowData = row
        
        // 3.push
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    // go to BookVC
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: BookViewController.identifier) as? BookViewController else { return }
                
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func BoxOfficeButton(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: BoxOfficeViewController.identifier) as? BoxOfficeViewController else { return }
                
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func loadTvshowData() {
        
        TrendMediaAPIManager.shared.fetchTrendMediaData(page: pageNum) { json in
            
            for tvshow in json["results"].arrayValue {
                let title = tvshow["original_name"].stringValue
                let rate = tvshow["vote_average"].doubleValue
                let posterImage = tvshow["poster_path"].stringValue
                
                let data = TrendMediaTVModel(original_name: title, vote_average: rate, poster_path: posterImage)
                self.trendMediaTVList.append(data)
                
            }
            
            self.tvshowTableView.reloadData()
            print("trendMediaTVList: \(self.trendMediaTVList)") // 20개가 나온다
            print(self.trendMediaTVList.count)
            
        }
        
    }
    
}


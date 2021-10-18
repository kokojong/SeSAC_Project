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
        titleLabel.text = tvshowData?.title
        
        // 기본적인 방법으로 URL -> Image
//        let url = URL(string: tvshowData?.backdropImage ?? "")
//        let data = try? Data(contentsOf: url!)
//        backgroundImageView.image = UIImage(data: data!)
//        posterImageView.image = UIImage(data: data!)
        
        // kingfisher를 사용한 버전
        let url = URL(string: tvshowData?.backdropImage ?? "")
        backgroundImageView.kf.setImage(with: url)
        posterImageView.kf.setImage(with: url)
        
        
        
        // 뒤로가기 버튼을 커스텀(주석 부분은 실패)
//        navigationController?.popViewController(animated: true)
//        navigationItem.backButtonTitle = "뒤로가기"
        navigationItem.title = "출연/제작"
        self.navigationController?.navigationBar.topItem?.title = "뒤로가기"
        
        
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = castTableView.dequeueReusableCell(withIdentifier: "CastTableViewCell") as? CastTableViewCell else {
            return UITableViewCell()
        }
        
        cell.castImageView.image = UIImage(systemName: "person")
        cell.nameLabel.text = "kokojong"
        cell.roleLabel.text = "iOS - dev"
        
        
        
        return cell
        
    }
    

    
    

    

}

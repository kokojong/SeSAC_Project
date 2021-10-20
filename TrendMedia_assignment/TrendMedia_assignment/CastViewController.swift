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
        
        // overviewCell
        castTableView.estimatedRowHeight = 44
        castTableView.rowHeight = UITableView.automaticDimension
        
        
        
        
        
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
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
            
            cell.overviewLabel.text = "asdfasdgasdg asdfasdgasdg asdfasdgasdg asdfasdgasdg asdfasdgasdg asdfasdgasdg asdfasdgasdg asdfasdgasdg asdfasdgasdg asdfasdgasdg asdfasdgasdg asdfasdgasdg asdfasdgasdg asdfasdgasdg "
            
            cell.overviewButton.addTarget(self, action: #selector(overviewButtonClicked(overviewButton: )), for: .touchUpInside)
            
            return cell
            
        } else {
            
            guard let cell = castTableView.dequeueReusableCell(withIdentifier: "CastTableViewCell") as? CastTableViewCell else {
                return UITableViewCell()
            }
            
            cell.castImageView.image = UIImage(systemName: "person")
            cell.nameLabel.text = "kokojong"
            cell.roleLabel.text = "iOS - dev"
            
            
            
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
        return 2
    }

    
    

    

}

//
//  HomeViewController.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.items![0].title = NSLocalizedString("homeTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
        self.tabBarController?.tabBar.items![1].title = NSLocalizedString("searchTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
        self.tabBarController?.tabBar.items![2].title = NSLocalizedString("calendarTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
        self.tabBarController?.tabBar.items![3].title = NSLocalizedString("settingTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
        
        title = NSLocalizedString("homeTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    

    @IBAction func onAddButtonClicked(_ sender: UIBarButtonItem) {
        
        // 1. sb
        let sb = UIStoryboard(name: "Content", bundle: nil)
        
        // 2. vc
        let vc = sb.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        // 2-1 navController embed
        let nav = UINavigationController(rootViewController: vc)
        
        // 2-2. present 방식(fullscreen)
        nav.modalPresentationStyle = .fullScreen
        
        // 3. present
        present(nav, animated: true, completion: nil)
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identiifer, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.categoryLabel.backgroundColor = .yellow
        cell.collectionVIew.backgroundColor = .lightGray
        // cell 파일에서 처리 해보기
        cell.collectionVIew.delegate = self
        cell.collectionVIew.dataSource = self
        cell.collectionVIew.tag = indexPath.row
        cell.collectionVIew.isPagingEnabled = true
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? 300 : 170
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.imageView.backgroundColor = .brown
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 테이블 뷰 셀의 인덱스 패스를 어떻게 가지고 와야할까?
        if collectionView.tag == 0{
            return CGSize(width: UIScreen.main.bounds.width, height: 100)
        } else {
            return CGSize(width: 150, height: 100)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView.tag == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.tag == 0 ? 0 : 10
        
    }
    
    
    

}

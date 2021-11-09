//
//  HomeViewController.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let array = [
        Array(repeating: "a", count: 20),
        Array(repeating: "b", count: 15),
        Array(repeating: "c", count: 10),
        Array(repeating: "d", count: 5),
        Array(repeating: "e", count: 20),
    ]
    
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
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identiifer, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.categoryLabel.text = "\(array[indexPath.row])"
        
        cell.categoryLabel.backgroundColor = .yellow
        cell.collectionVIew.backgroundColor = .lightGray
        
        // cell 파일에서 처리 해보기
        cell.data = array[indexPath.row] // 데이터 넘겨주기
        
//        cell.collectionVIew.delegate = self
//        cell.collectionVIew.dataSource = self
        
        cell.collectionVIew.tag = indexPath.row
//        cell.collectionVIew.isPagingEnabled = true
//        cell.collectionVIew.reloadData()
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? 300 : 170
    }
    
    
}


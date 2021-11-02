//
//  SearchViewController.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchTableView.estimatedRowHeight = 150
        searchTableView.rowHeight = UITableView.automaticDimension
        
        title = NSLocalizedString("searchTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
     
        tasks = localRealm.objects(UserDiary.self)
        print(tasks)
        
    }
    
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        let row = tasks[indexPath.row]
        
        cell.titleLabel.text = row.diaryTitle
        cell.titleLabel.font = UIFont().mainBlack
        cell.dateLabel.text = "\(row.diaryDate)"
        cell.mainImageView.image = UIImage(systemName: "person")
        cell.contentLabel.text = row.diaryContent
        
        return cell
        
        
    }
    
    
}

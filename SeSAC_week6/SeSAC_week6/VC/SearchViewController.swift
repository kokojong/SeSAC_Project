//
//  SearchViewController.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchTableView.estimatedRowHeight = 150
        searchTableView.rowHeight = UITableView.automaticDimension
        
        title = NSLocalizedString("searchTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
        
    }
    
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = "타 이 틀"
        cell.titleLabel.font = UIFont().mainBlack
        cell.dateLabel.text = "날 짜"
        cell.mainImageView.image = UIImage(systemName: "person")
        cell.contentLabel.text = "내요용용내요용용내요용용내요용용내요용용내요용용내요용용내요용용"
        
        return cell
        
        
    }
    
    
}

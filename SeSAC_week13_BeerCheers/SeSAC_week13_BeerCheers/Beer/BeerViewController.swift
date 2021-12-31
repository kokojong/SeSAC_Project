//
//  BeerViewController.swift
//  SeSAC_week13_BeerCheers
//
//  Created by kokojong on 2021/12/30.
//

import UIKit
import SnapKit

class BeerViewController: UIViewController {
    
    var mainview = BeerView()
    
    override func loadView() {
        self.view = mainview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mainview.tableView.delegate = self
        mainview.tableView.dataSource = self
//        mainview.tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
//        mainview.tableView.style = .insetGrouped
//        mainview.tableView.separatorStyle = .d
        
        mainview.tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: BeerTableViewCell.identifier)
    }
}

extension BeerViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier, for: indexPath) as? BeerTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .red
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return BeerTableHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
}

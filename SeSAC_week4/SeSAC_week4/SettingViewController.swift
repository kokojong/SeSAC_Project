//
//  SettingViewController.swift
//  SeSAC_week4
//
//  Created by kokojong on 2021/10/18.
//

import UIKit

// CaseIterable
enum SettingSection : Int, CaseIterable {
    case authorizeation
    case onlineShop
    case question
    
    var description : String {
        switch self {
        case .authorizeation:
            return "알림 설정"
        case .onlineShop:
            return "온라인 스토어"
        case .question:
            return "Q&A"
        }
    }
}

class SettingViewController: UIViewController {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    let settingList = [
        ["위치 알림 설정", "카메라 알림 설정"],
        ["교보 문고","반디엔 루이스"],
        ["리뷰 작성하기","문의하기"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        let nibName = UINib(nibName: DefaultTableViewCell.identifier, bundle: nil)
        settingTableView.register(nibName, forCellReuseIdentifier: DefaultTableViewCell.identifier)
        
    }
    
}

extension SettingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell else { return UITableViewCell()}
        
        cell.iconImageView.backgroundColor = .blue
        cell.titleLable.text = settingList[indexPath.section][indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingSection.allCases[section].description
    }
    
}


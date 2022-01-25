//
//  ProfileViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/24.
//

import UIKit

class ProfileViewController: UIViewController {

    var mainTableView = UITableView()
    
    var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "내정보"
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MyProfileTableViewCell.self, forCellReuseIdentifier: MyProfileTableViewCell.identifier)
        mainTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.backgroundColor = .green
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    

 

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyProfileTableViewCell.identifier, for: indexPath) as? MyProfileTableViewCell else { return UITableViewCell() }
            
            cell.usernameLabel.text = viewModel.userInfo.value.nick
        
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
         
            cell.iconImageView.image = viewModel.cellForRowAt(indexPath: indexPath).0
            cell.titleLabel.text = viewModel.cellForRowAt(indexPath: indexPath).1
            
            
            return cell
        }
    }
    
    
}

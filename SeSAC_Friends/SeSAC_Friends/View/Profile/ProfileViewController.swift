//
//  ProfileViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/24.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    var mainTableView = UITableView()
    
    var viewModel = ProfileViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.viewModel.getUserInfo { userInfo, status, error in
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "내정보"
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MyProfileTableViewCell.self, forCellReuseIdentifier: MyProfileTableViewCell.identifier)
        mainTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.backgroundColor = .magenta
       
        view.backgroundColor = .white
        view.addSubview(mainTableView)
        
//        viewModel.userInfo.bind {
//            self.title = $0.nick
//            self.mainTableView.reloadData()
//        }
        
        viewModel.myUserInfo.bind { userinfo in
            self.mainTableView.reloadData()
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
    }
    

 

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numberOfRowsInSection
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyProfileTableViewCell.identifier, for: indexPath) as? MyProfileTableViewCell else { return UITableViewCell() }
            
            viewModel.myUserInfo.bind { userInfo in
                cell.usernameLabel.text = userInfo.nick
            }
            cell.backgroundColor = .white
        
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
         
            cell.iconImageView.image = UIImage(named: viewModel.cellForRowAt(indexPath: indexPath).0)
            cell.titleLabel.text = viewModel.cellForRowAt(indexPath: indexPath).1
            
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = ProfileDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

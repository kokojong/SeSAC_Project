//
//  ViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/26.
//

import UIKit
import SnapKit

class ProfileDetailViewController: UIViewController {
    
    let scrollView = UIScrollView()

    let backgroundView = ProfileBackgroundView()
    
    let toggleTableView = UITableView()
    
    let settingView = UIView()
    
    var isOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "정보 관리"

        view.backgroundColor = .white
        
        addViews()
        addConstraints()
        configViews()
        
        toggleTableView.delegate = self
        toggleTableView.dataSource = self
        toggleTableView.register(ClosedTableViewCell.self, forCellReuseIdentifier: ClosedTableViewCell.identifier)
        toggleTableView.register(OpenedTableViewCell.self, forCellReuseIdentifier: OpenedTableViewCell.identifier)
        toggleTableView.rowHeight = UITableView.automaticDimension
//        toggleTableView.rowHeight = 100
        toggleTableView.isUserInteractionEnabled = true
        
        
      
    }
    
    func addViews() {
        view.addSubview(backgroundView)
        view.addSubview(toggleTableView)
    }
    
    func addConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            
        }
        
        toggleTableView.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
    }
    
    func configViews() {
        backgroundView.backgroundColor = .yellow
        toggleTableView.backgroundColor = .red
        
    }
    
    @objc func onToggleButtonClicked() {
        isOpen.toggle()
        print(#function)
        toggleTableView.reloadData()
        
    }
    

}

extension ProfileDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isOpen {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:OpenedTableViewCell.identifier, for: indexPath) as? OpenedTableViewCell else { return UITableViewCell() }
            
            cell.nicknameLabel.text = "으아아ㅏ"
            cell.moreButton.setImage(UIImage(named: "more_arrow_down"), for: .normal)
            cell.moreButton.addTarget(self, action: #selector(onToggleButtonClicked), for: .touchUpInside)
        
            cell.sesacTitleCollectionView.delegate = self
            cell.sesacTitleCollectionView.dataSource = self
            return cell
            
            
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:ClosedTableViewCell.identifier, for: indexPath) as? ClosedTableViewCell else { return UITableViewCell() }
            
            cell.nicknameLabel.text = "코로로로종"
            cell.moreButton.setImage(UIImage(named: "more_arrow_up"), for: .normal)
            cell.moreButton.addTarget(self, action: #selector(onToggleButtonClicked), for: .touchUpInside)
        
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isOpen.toggle()
        print(#function)
        toggleTableView.reloadData()
    }
    
    
    
    
}

extension ProfileDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SesacTitleCollectionViewCell.identifier, for: indexPath) as? SesacTitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.button.setTitle("테스또", for: .normal)
        
        return cell
        
    }
    
    
}

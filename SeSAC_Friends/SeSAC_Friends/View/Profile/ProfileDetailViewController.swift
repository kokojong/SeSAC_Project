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
    
    let bottomView = ProfileDetailBottomView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleTableView.reloadData()
    }
    
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
        toggleTableView.estimatedRowHeight = 310
        toggleTableView.isUserInteractionEnabled = true
        
        toggleTableView.reloadData()
        
        
        
        
      
    }
    
    func addViews() {
        view.addSubview(backgroundView)
        view.addSubview(toggleTableView)
        view.addSubview(bottomView)
    }
    
    func addConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            
        }
        
        toggleTableView.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
//            make.height.equalTo(200)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func configViews() {
        backgroundView.backgroundColor = .yellow
        toggleTableView.backgroundColor = .red
        toggleTableView.isScrollEnabled = false
        
        bottomView.backgroundColor = .yellow
        
    }
    
    @objc func onToggleButtonClicked() {
        isOpen.toggle()
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
            cell.moreButton.setImage(UIImage(named: "more_arrow_up"), for: .normal)
            cell.moreButton.addTarget(self, action: #selector(onToggleButtonClicked), for: .touchUpInside)
        
//            cell.sesacTitleCollectionView.delegate = self
//            cell.sesacTitleCollectionView.dataSource = self
//            cell.sesacTitleCollectionView.register(SesacTitleCollectionViewCell.self, forCellWithReuseIdentifier: SesacTitleCollectionViewCell.identifier)
            
            return cell
            
            
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:ClosedTableViewCell.identifier, for: indexPath) as? ClosedTableViewCell else { return UITableViewCell() }
            
            cell.nicknameLabel.text = "코로로로종"
            cell.moreButton.setImage(UIImage(named: "more_arrow_down"), for: .normal)
            cell.moreButton.addTarget(self, action: #selector(onToggleButtonClicked), for: .touchUpInside)
        
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isOpen {
            return UITableView.automaticDimension
//            return 310
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toggleTableView.reloadData()
        isOpen.toggle()
        toggleTableView.reloadData()
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 310
//    }
    
    
    
    
}

//extension ProfileDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 6
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SesacTitleCollectionViewCell.identifier, for: indexPath) as? SesacTitleCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        
//        cell.button.setTitle("테스또", for: .normal)
//        
//        return cell
//        
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 200, height: 32)
//    }
//
//}

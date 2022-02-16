//
//  OpenedProfileTableViewCell.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/15.
//

import UIKit
import SnapKit

protocol matchButtonProtocol {
    func matchButtonClicked()
}

class OpenedProfileTableViewCell: UITableViewCell, UiViewProtocol {
    
    var delegate: matchButtonProtocol!
    
    static let identifier = "OpenedProfileTableViewCell"
    
    let profileBackgroundView = ProfileBackgroundView().then {
        $0.matchButton.setTitle("요청하기", for: .normal)
        $0.matchButton.backgroundColor = UIColor.errorColor
    }
    
    let toggleTableView = UITableView()
    
    var viewModel = HomeViewModel.shared
    
    var otherUserInfoData: OnQueueResult.OtherUserInfo!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        addConstraints()
        
        toggleTableView.backgroundColor = .red
        toggleTableView.allowsSelection = false
        
        toggleTableView.delegate = self
        toggleTableView.dataSource = self
        toggleTableView.register(OpenedTableViewCell.self, forCellReuseIdentifier: OpenedTableViewCell.identifier)
        profileBackgroundView.matchButton.addTarget(self, action: #selector(onMatchButtonClicked), for: .touchUpInside)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addViews() {
        contentView.addSubview(profileBackgroundView)
        contentView.addSubview(toggleTableView)
//        addSubview(profileBackgroundView)
//        addSubview(toggleTableView)
    }
    
    func addConstraints() {
        profileBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            
        }
        
        toggleTableView.snp.makeConstraints { make in
            make.top.equalTo(profileBackgroundView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            
            make.height.equalTo(58)
        }
    }
    
               
    @objc func onMatchButtonClicked() {
        print("otherUserInfoData",otherUserInfoData)
        
        UserDefaults.standard.set(otherUserInfoData.uid, forKey: UserDefaultKeys.otherUid.rawValue)
        
        self.delegate.matchButtonClicked()
       
    }
                                          
}

extension OpenedProfileTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OpenedTableViewCell.identifier, for: indexPath) as? OpenedTableViewCell else {
             return UITableViewCell()
        }
        
        
        cell.nicknameLabel.text = otherUserInfoData.nick
        
        cell.layoutIfNeeded()
        
        DispatchQueue.main.async {
            self.toggleTableView.snp.updateConstraints { make in
                make.height.equalTo(self.toggleTableView.contentSize.height)
            }
            
        }
        
        return cell
        
    }
    
  
    
}

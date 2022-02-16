//
//  HomeRecievedRequestsViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/14.
//

import UIKit
import Tabman
import Pageboy

class HomeRecievedRequestsViewController: TabmanViewController, UiViewProtocol {
    
    var viewModel = HomeViewModel.shared
    
    var mainTableView = UITableView()
    
    let buttonStackView = UIStackView().then {
        $0.distribution = .fillProportionally
        $0.spacing = 8
        $0.axis = .horizontal
    }
    
    let changeHobbyButton = MainButton(type: .fill).then {
        $0.setTitle("취미 변경하기", for: .normal)
    }
    
    let refreshButton = MainButton(type: .outline).then {
        $0.setImage(UIImage(named: "refresh"), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let form = OnQueueForm(region: viewModel.centerRegion.value, lat: viewModel.centerLat.value, long: viewModel.centerLong.value)
        
        viewModel.searchNearFriends(form: form) { onqueueResult, statuscode, error in
            self.mainTableView.reloadData()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "받은 요청"
        view.backgroundColor = .red
        
        mainTableView.allowsSelection = false
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(OpenedProfileTableViewCell.self, forCellReuseIdentifier: OpenedProfileTableViewCell.identifier)
        mainTableView.backgroundColor = .yellow
        
        changeHobbyButton.addTarget(self, action: #selector(onChangeHobbyButtonClicked), for: .touchUpInside)
        
        refreshButton.addTarget(self, action: #selector(onRefreshButtonClicked), for: .touchUpInside)
        
        addViews()
        addConstraints()
        
    }
    
    func addViews() {
        view.addSubview(mainTableView)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(changeHobbyButton)
        buttonStackView.addArrangedSubview(refreshButton)
    }
    
    func addConstraints() {
        mainTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(500)
            
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
    }
    
    @objc func onChangeHobbyButtonClicked() {
        viewModel.deleteQueue { statuscode, error in
         
            self.view.makeToast("\(statuscode)")
            
            switch statuscode {
            case DeleteQueueStatusCodeCase.success.rawValue:
                UserDefaults.standard.set(MyStatusCase.normal.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                self.navigationController?.pushViewController(HomeHobbyViewController(), animated: true)
            case DeleteQueueStatusCodeCase.matched.rawValue:
                self.view.makeToast("누군가와 취미를 함께하기로 약속하셨어요!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.pushViewController(HomeChattingViewController(), animated: true)
                }
               
            default:
                self.view.makeToast("오류가 발생했습니다. 잠시 후 다시 시도해주세요.")
                
            }
        }
    }
    
    @objc func onRefreshButtonClicked() {
        print(#function)
//        searchNearFriends()
        view.makeToast("새싹 목록을 갱신했습니다.")
    }
}

extension HomeRecievedRequestsViewController: UITableViewDelegate, UITableViewDataSource, matchButtonProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.filteredQueueDBRequested.value.count
        print("count", count)
        if count != 0 {
            tableView.backgroundView = nil
            buttonStackView.isHidden = true
            return count
        } else {
            let emptyView = EmptyResultView().then({
                $0.titleLabel.text = "아직 받은 요청이 없어요ㅠ"
                $0.subtitleLabel.text = "취미를 변경하거나 조금만 더 기다려 주세요"
            })
            tableView.backgroundView = emptyView
            
            buttonStackView.isHidden = false
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OpenedProfileTableViewCell.identifier, for: indexPath) as? OpenedProfileTableViewCell else {
             return UITableViewCell()
        }
        
        guard let innerCell = cell.toggleTableView.dequeueReusableCell(withIdentifier: OpenedTableViewCell.identifier, for: indexPath) as? OpenedTableViewCell else {
            return UITableViewCell()
        }
        
        cell.profileBackgroundView.matchButton.setTitle("수락하기", for: .normal)
        cell.profileBackgroundView.matchButton.backgroundColor = UIColor.successColor
        
        print("viewModel.filteredQueueDBRequested.value",viewModel.filteredQueueDBRequested.value)
        cell.otherUserInfoData = viewModel.filteredQueueDBRequested.value[indexPath.row]
        
        cell.toggleTableView.reloadData()
        cell.delegate = self
        
        DispatchQueue.main.async {
            self.mainTableView.snp.updateConstraints { make in
                make.height.equalTo(self.mainTableView.contentSize.height)
            }

        }
        
        return cell
    }
    
    func matchButtonClicked() {
        let vc = PopupViewController() 
        vc.titleLabel.text = "취미 같이 하기를 수락할까요?"
        vc.subtitleLabel.text = "요청이 수락되면 채팅창에서 상대와 대화를 나눌 수 있어요"
        vc.modalTransitionStyle = . crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.popupCase = PopupVCCase.hobbyAceept.rawValue
        present(vc, animated: true, completion: nil)
    }
    
    
}

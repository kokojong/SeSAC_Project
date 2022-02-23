//
//  HomeNearSesacViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/14.
//

import UIKit
import SnapKit
import Then
import CoreLocation
import Toast


class HomeNearSesacViewController: UIViewController, UiViewProtocol {
    
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
        
        viewModel.onQueueResult.bind { _ in
            self.mainTableView.reloadData()
        }
        
//
        searchNearFriends()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "주변 새싹"
        view.backgroundColor = .white
        
        mainTableView.allowsSelection = false
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(OpenedOtherProfileTableViewCell.self, forCellReuseIdentifier: OpenedOtherProfileTableViewCell.identifier)
        
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
           
            print(statuscode)
            switch statuscode {
            case DeleteQueueStatusCodeCase.success.rawValue:
                UserDefaults.standard.set(MyStatusCase.normal.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                self.navigationController?.pushViewController(HomeHobbyViewController(), animated: true)
            case DeleteQueueStatusCodeCase.matched.rawValue:
                self.view.makeToast("누군가와 취미를 함께하기로 약속하셨어요!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.navigationController?.pushViewController(HomeChattingViewController(), animated: true)
                }
               
            default:
                self.view.makeToast("오류가 발생했습니다. 잠시 후 다시 시도해주세요.")
            }
        }
        
    }
    
    @objc func onRefreshButtonClicked() {
        print(#function)
        searchNearFriends()
        view.makeToast("새싹 목록을 갱신했습니다.")
    }

}

extension HomeNearSesacViewController: CLLocationManagerDelegate {
    func searchNearFriends() {
        print(#function)
        
        let form = OnQueueForm(region: viewModel.centerRegion.value, lat: viewModel.centerLat.value, long: viewModel.centerLong.value)
        viewModel.searchNearFriends(form: form) { onqueueResult, statuscode, error in
            
            switch statuscode {
            case OnQueueStatusCodeCase.success.rawValue:
                guard let onqueueResult = onqueueResult else {
                    return
                }
                
                print(onqueueResult)
                
                // MARK: onqueue의 결과를 VM에 저장
                for otherUserInfo in onqueueResult.fromQueueDB {
                    
                    self.viewModel.fromNearFriendsHobby.value.append(contentsOf: otherUserInfo.hf)
                    
                    self.viewModel.fromNearFriendsHobby.value = Array(Set(self.viewModel.fromNearFriendsHobby.value))
                    
                }
                
                for otherUserInfo in onqueueResult.fromQueueDBRequested {
                    
                    self.viewModel.fromNearFriendsHobby.value.append(contentsOf: otherUserInfo.hf)
                    
                    self.viewModel.fromNearFriendsHobby.value = Array(Set(self.viewModel.fromNearFriendsHobby.value))
                }
                
                self.viewModel.fromRecommendHobby.value =  onqueueResult.fromRecommend
                
                switch self.viewModel.searchGender.value {
                    
                case GenderCase.man.rawValue, GenderCase.woman.rawValue:
                    self.viewModel.filteredQueueDB.value = onqueueResult.fromQueueDB.filter({
                        $0.gender == self.viewModel.searchGender.value
                    })
                default:
                    self.viewModel.filteredQueueDB.value = onqueueResult.fromQueueDB
                }
                
                self.viewModel.filteredQueueDBRequested.value = onqueueResult.fromQueueDBRequested
                
                print("filteredQueueDB", self.viewModel.filteredQueueDB.value)
                print("filteredQueueDBRequested", self.viewModel.filteredQueueDBRequested.value)
                
               
               
           case OnQueueStatusCodeCase.firebaseTokenError.rawValue:
               // 토큰 만료 -> 갱신
               self.refreshFirebaseIdToken { idToken, error in
                   if let idToken = idToken {
                       self.searchNearFriends()
                   }
               }
           default:
               self.view.makeToast("주변 새싹 친구를 찾는데 실패했습니다. 잠시 후 다시 시도해주세요")
           }
       }
        
        mainTableView.reloadData()
   }
}

extension HomeNearSesacViewController: UITableViewDelegate, UITableViewDataSource, matchButtonProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = viewModel.filteredQueueDB.value.count
        print("count", count)
        if count != 0 {
            tableView.backgroundView = nil
            buttonStackView.isHidden = true
            return count
        } else {
            let emptyView = EmptyResultView().then({
                $0.titleLabel.text = "아쉽게도 주변 새싹이 없어요ㅠ"
                $0.subtitleLabel.text = "취미를 변경하거나 조금만 더 기다려 주세요"
            })
            tableView.backgroundView = emptyView
            
            buttonStackView.isHidden = false
            
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OpenedOtherProfileTableViewCell.identifier, for: indexPath) as? OpenedOtherProfileTableViewCell else {
             return UITableViewCell()
        }
        
        guard let innerCell = cell.toggleTableView.dequeueReusableCell(withIdentifier: OpenedTableViewCell.identifier, for: indexPath) as? OpenedTableViewCell else {
            return UITableViewCell()
        }
        
        print("viewModel.filteredQueueDB.value",viewModel.filteredQueueDB.value)
        cell.otherUserInfoData = viewModel.filteredQueueDB.value[indexPath.row]
        
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
        let vc = HobbyPopupViewController() 
        vc.mainView.titleLabel.text = "취미 같이 하기를 요청할게요"
        vc.mainView.subtitleLabel.text = "요청이 수락되면 30분 후에 리뷰를 남길 수 있어요"
        vc.modalTransitionStyle = . crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.popupCase = PopupVCCase.hobbyRequest.rawValue
        present(vc, animated: true, completion: nil)
    }
    
}

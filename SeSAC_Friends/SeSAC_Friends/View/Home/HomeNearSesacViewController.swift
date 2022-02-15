//
//  HomeNearSesacViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/14.
//

import UIKit
import SnapKit
import Then

class HomeNearSesacViewController: UIViewController, UiViewProtocol{
    
    var viewModel = HomeViewModel.shared
    
    var mainTableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let form = OnQueueForm(region: viewModel.centerRegion.value, lat: viewModel.centerLat.value, long: viewModel.centerLong.value)
        
        viewModel.searchNearFriends(form: form) { onqueueResult, statuscode, error in
            self.mainTableView.reloadData()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "주변 새싹"
        view.backgroundColor = .magenta
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(OpenedProfileTableViewCell.self, forCellReuseIdentifier: OpenedProfileTableViewCell.identifier)
        mainTableView.backgroundColor = .yellow
        
        
        
        addViews()
        addConstraints()
    }
    
    func addViews() {
        view.addSubview(mainTableView)
    }
    
    func addConstraints() {
        mainTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(500)
        }
    }
    
    


}

extension HomeNearSesacViewController: UITableViewDelegate, UITableViewDataSource, matchButtonProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = viewModel.onQueueResult.value.fromQueueDB.count
        print("count", count)
        if count != 0 {
            tableView.backgroundView = nil
            return count
        } else {
            let emptyView = EmptyResultView().then({
                $0.titleLabel.text = "아쉽게도 주변 새싹이 없어요ㅠ"
                $0.subtitleLabel.text = "취미를 변경하거나 조금만 더 기다려 주세요"
            })
            tableView.backgroundView = emptyView
            
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

//        print(viewModel.onQueueResult.value.fromQueueDB[indexPath.row].nick)
        
        viewModel.onQueueResult.bind {
            
            cell.otherUserInfoData = $0.fromQueueDB[indexPath.row]
            
            cell.toggleTableView.reloadData()

        }
        
        cell.delegate = self
        
        
        
//        cell.layoutIfNeeded()
        
        DispatchQueue.main.async {
            self.mainTableView.snp.updateConstraints { make in
                make.height.equalTo(self.mainTableView.contentSize.height)
            }

        }
        
        return cell
    }
    
    func matchButtonClicked(){
        let vc = PopupViewController() // Or however you want to create it.
        vc.titleLabel.text = "취미 같이 하기를 요청할게요"
        vc.subtitleLabel.text = "요청이 수락되면 30분 후에 리뷰를 남길 수 있어요"
        vc.modalTransitionStyle = . crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    
    @objc func onMatchButtonClicked() {
        print(#function)
    }
    
}

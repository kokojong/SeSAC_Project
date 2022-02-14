//
//  HomeNearSesacViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/14.
//

import UIKit
import SnapKit

class HomeNearSesacViewController: UIViewController, UiViewProtocol{
   
    
    
    var viewModel = HomeViewModel.shared
    
    var mainTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "주변 새싹"
        view.backgroundColor = .magenta
        
        
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
        }
    }
    
    


}

extension HomeNearSesacViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = viewModel.onQueueResult.value.fromQueueDB.count
        if count < 0 {
            tableView.backgroundView = nil
        } else {
            tableView.backgroundView = EmptyResultView().then({
                $0.titleLabel.text = "아쉽게도 주변 새싹이 없어요ㅠ"
                $0.subtitleLabel.text = "취미를 변경하거나 조금만 더 기다려 주세요"
            })
        }
        
        return count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    
}

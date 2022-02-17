//
//  HomeChattingViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/17.
//

import UIKit
import SnapKit

class HomeChattingViewController: UIViewController {
    
    let resetButton = UIButton().then {
        $0.setTitle("reset", for: .normal)
    }
    
    let mainTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .brown
        title = "채팅"
        
        setNavBackArrowButton()
        let moreButton = UIBarButtonItem(image: UIImage(named: "ellipsis.vertical"), style: .done, target: self, action: #selector(onMoreButtonClicked))
        moreButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = moreButton
        
        
        resetButton.addTarget(self, action: #selector(onResetButtonClicked), for: .touchUpInside)
        
        view.addSubview(resetButton)
        resetButton.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    @objc func onResetButtonClicked() {
        print(#function)
        UserDefaults.standard.set(MyStatusCase.normal.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
    }
    
    @objc func onMoreButtonClicked() {
        print(#function)
    }
    
}

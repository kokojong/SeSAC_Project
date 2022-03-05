//
//  ShopBackgroundViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/03/05.
//

import UIKit

class ShopBackgroundViewController: UIViewController {

    let mainTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .green
        
        addViews()
        addConstraints()
        
    }
    

    func addViews() {
        view.addSubview(mainTableView)
        
    }
    
    func addConstraints(){
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(235) // ProfileBackgroundView의 높이 + inset
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
    }
  

}

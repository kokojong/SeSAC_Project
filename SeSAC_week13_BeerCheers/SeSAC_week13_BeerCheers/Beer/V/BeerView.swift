//
//  BeerView.swift
//  SeSAC_week13_BeerCheers
//
//  Created by kokojong on 2021/12/30.
//

import Foundation
import UIKit

protocol BeerViewRepresentable {
    func setupView()
    func setupConstraints()
}

class BeerView: UIView, BeerViewRepresentable {
    
    var viewModel = BeerViewModel()
    
    var tableView = UITableView()
    
    var bottomView = BottomView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    func setupView() {
//        tableView.tableHeaderView = BeerTableHeaderView(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: viewModel.descriptionViewHeight.value * 3))
        
        viewModel.descriptionViewHeight.bind { int in
            print("bind2:",int)
//            self.tableView.tableHeaderView = BeerTableHeaderView(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: .zero))
        }
        addSubview(tableView)
        tableView.backgroundColor = .yellow
        
        addSubview(bottomView)
        bottomView.backgroundColor = .orange
    }
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
    }
    
    
    
}

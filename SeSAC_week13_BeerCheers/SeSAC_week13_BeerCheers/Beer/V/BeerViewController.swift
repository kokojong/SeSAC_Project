//
//  BeerViewController.swift
//  SeSAC_week13_BeerCheers
//
//  Created by kokojong on 2021/12/30.
//

import UIKit
import SnapKit

class BeerViewController: UIViewController {
    
    var mainview = BeerView()
    
    var viewModel = BeerViewModel()
    
//    var headerView = BeerTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400))
    
    override func loadView() {
        self.view = mainview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mainview.tableView.delegate = self
        mainview.tableView.dataSource = self
//        mainview.tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
//        mainview.tableView.style = .insetGrouped
//        mainview.tableView.separatorStyle = .d
        
        mainview.tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: BeerTableViewCell.identifier)
        print("before change",viewModel.descriptionViewHeight.value)
        mainview.tableView.tableHeaderView = BeerTableHeaderView(frame: CGRect(x: 0, y: 0, width: Int(self.view.bounds.width), height: viewModel.descriptionViewHeight.value*3))
        
        
//        mainview.tableView.layoutIfNeeded()
        viewModel.descriptionViewHeight.bind { int in
            print("bind int",int)
//            self.mainview.tableView.tableHeaderView = BeerTableHeaderView(frame: CGRect(x: 0, y: 0, width: Int(self.view.bounds.width), height: self.viewModel.descriptionViewHeight.value*3))
        }
        
        
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        if let headerView = mainview.tableView.tableHeaderView {
//
//            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
//            var headerFrame = headerView.frame
//
//            //Comparison necessary to avoid infinite loop
//            if height != headerFrame.size.height {
//                headerFrame.size.height = height
//                headerView.frame = headerFrame
//                mainview.tableView.tableHeaderView = headerView
//            }
//        }
//    }
}

extension BeerViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier, for: indexPath) as? BeerTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .red
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 600
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return BeerTableHeaderView()
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 300
//    }
    
}

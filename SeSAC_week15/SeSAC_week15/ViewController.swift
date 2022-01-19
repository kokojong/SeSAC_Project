//
//  ViewController.swift
//  SeSAC_week15
//
//  Created by kokojong on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {

    var tableView = UITableView()
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
        
//        let items = Observable.just([
//            "First Item",
//            "Second Item",
//            "Third Item"
//        ])
        
//        items
        viewModel.items
        .bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .map({ text in
                "\(text)를 클릭했습니다"
            })
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.navigationController?.pushViewController(Operator(), animated: true)
            self.present(Operator(), animated: true, completion: nil)
        }
        
    }

    func setUp() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(label)
        label.backgroundColor = .lightGray
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
}

class ViewModel {
    
    let items = Observable.just([
        "First Item",
        "Second Item",
        "Third Item"
    ])
    
}

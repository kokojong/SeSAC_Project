//
//  PickerViewController.swift
//  SeSAC_week15
//
//  Created by kokojong on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PickerViewController: UIViewController {
    
    let pickerView = UIPickerView()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUp()
        
        let items = Observable.just([
                "First Item",
                "Second Item",
                "Third Item"
            ])
     
        items
            .bind(to: pickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(String.self)
            .subscribe { value in
                print("PICKER SELECT \(value)")
                
            }
            .disposed(by: disposeBag)
        
    }
    

    func setUp() {
        view.addSubview(pickerView)
        pickerView.backgroundColor = .yellow
        pickerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }
}

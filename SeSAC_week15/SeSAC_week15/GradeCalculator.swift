//
//  GradeCalculator.swift
//  SeSAC_week15
//
//  Created by kokojong on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class GradeCalculator: UIViewController {
    
    let mySwitch = UISwitch()
    
    let first = UITextField()
    let second = UITextField()
    let resultLabel = UILabel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        
        Observable.combineLatest(first.rx.text.orEmpty, second.rx.text.orEmpty) { val1, val2 -> Double in
            return ((Double(val1) ?? 0.0) + (Double(val2) ?? 0.0)) / 2
        }
        .map {$0.description }
        .map { "\($0)입니다"}
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
        
        Observable.of(false)
            .bind(to: mySwitch.rx.isOn)
            .disposed(by: disposeBag)
        
    }
    
    
    func setup() {
        view.addSubview(mySwitch)
        mySwitch.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(first)
        first.backgroundColor = .red
        first.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.size.equalTo(50)
            make.leading.equalTo(50)
        }
        
        view.addSubview(second)
        second.backgroundColor = .orange
        second.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.size.equalTo(50)
            make.leading.equalTo(120)
        }
        
        view.addSubview(resultLabel)
        resultLabel.backgroundColor = .yellow
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.leading.equalTo(200)
        }
    }
}

//
//  ButtonViewController.swift
//  SeSAC_week15
//
//  Created by kokojong on 2022/01/06.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ButtonViewModel: CommonViewModel {
    var disposeBag: DisposeBag = DisposeBag()
    
    struct Input {
        let tap: ControlEvent<Void>
        
    }
    
    struct Output {
        let text: Driver<String>
        
    }
    
    func tranform(input: Input) -> Output {
        let result = input.tap
            .map { "안녕 뷰모델"}
            .asDriver(onErrorJustReturn: "")
        
        return Output(text: result)
    }
}

class ButtonViewController: UIViewController {

    let button = UIButton()
    var label = UILabel()
    let viewModel = ButtonViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        button.backgroundColor = .yellow
        label.backgroundColor = .orange
        
        //        label.text = "안녕!"
        
        // 버튼 클릭 -> 안녕! -> 레이블
        // 구독 : 백그라운드 쓰레드

        
//        button
//            .rx.tap
//            .subscribe { value in
//                print(value)
//                // 일케 하는게 아닌가보오
////                self.viewModel.text
////                label.rx.text = "안녕!"
//                self.label.text = "안녕!"
//            }
        // 쓰레드를 변경해주기 위해서
//            .bind(to: { _ in
//                self.label.text = "안녕!"
//            })
//            .disposed(by: disposeBag)
        
//        button.rx.tap
//            .map { "안녕! 안녕!" }
//            .bind(to: label.rx.text)
//            .disposed(by: disposeBag)
        
        // ui적인거만 처리해주므로 drive
        button.rx.tap
            .map { "안녕! 안녕1"}
            .asDriver(onErrorJustReturn: "")
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        // VM을 이용해서 label의 text 바꿈
        bind()
        
    }
    
    func bind() {
        let input = ButtonViewModel.Input(tap: button.rx.tap)
        let output = viewModel.tranform(input: input)
        output.text
            .drive(label.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setup() {
        view.addSubview(button)
        view.addSubview(label)
        
        button.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.equalTo(20)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
    

  

}

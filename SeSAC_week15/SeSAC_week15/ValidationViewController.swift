//
//  ValidationViewController.swift
//  SeSAC_week15
//
//  Created by kokojong on 2022/01/05.
//

import UIKit
import RxSwift
import RxCocoa

// VM에서 반복이 되니까 프로토콜로 뺀다
protocol CommonViewModel {
    // generic (T) 와 비슷한 용도
    associatedtype Input
    associatedtype Output
    
    var disposeBag : DisposeBag { get set }
    
    func tranform(input: Input) -> Output
}

class ValidationViewModel: CommonViewModel {
    var disposeBag: DisposeBag = DisposeBag()
    
    var validText = BehaviorRelay<String>(value: "8자 이상")
    
    struct Input {
        let text: ControlProperty<String?>
        let tap :ControlEvent<Void>
        
        
    }

    struct Output {
        let validStatus: Observable<Bool>
        let validText: BehaviorRelay<String>
        let sceneTransition: ControlEvent<Void>
    }

    func tranform(input: Input) -> Output {
        let resultText = input.text
            .orEmpty // optional 해제
            .map{$0.count >= 8}
            .share(replay: 1, scope: .whileConnected) // buffer 사이즈
        
        return Output(validStatus: resultText, validText: validText, sceneTransition: input.tap)
    }
}

//class newVM : CommonViewModel {
//    typealias Input =
//
//    typealias Output =
//
//    func tranform(input: Input) -> Output {
//
//    }
//
//}

class ValidationViewController: UIViewController {

    let nameValidationLabel = UILabel()
    let nameTextField = UITextField()
    let button = UIButton()
    
    var viewModel = ValidationViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
        
    }
    
    func bind() {
        let input = ValidationViewModel.Input(text: nameTextField.rx.text, tap: button.rx.tap)
        let output = viewModel.tranform(input: input)
        
        output.validText
            .asDriver()
            .drive(nameValidationLabel.rx.text)
            .disposed(by: disposeBag)
            
        
//        output.validStatus
//            .bind(to: button.rx.isEnabled)
//            .disposed(by: disposeBag)
//        output.validStatus
//            .bind(to: nameValidationLabel.rx.isHidden)
//            .disposed(by: disposeBag)
        // 한줄로 끝내기
        output.validStatus
            .bind(to: button.rx.isEnabled, nameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in
                self.present(ReactiveViewController(), animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
    }
    
    func setup() {
        [nameValidationLabel,nameTextField,button].forEach {
            $0.backgroundColor = .white
            view.addSubview($0)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        nameValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(300)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
    
    // bind를 해주기 전에 원래 동작
    func beforeBind() {
        viewModel.validText
            .asDriver()
            .drive(nameValidationLabel.rx.text)
//            .bind(to: )
            .disposed(by: disposeBag)
        
        let validation = nameTextField
            .rx.text
            .orEmpty // optional 해제
            .map{$0.count >= 8}
            .share(replay: 1, scope: .whileConnected) // buffer 사이즈
        
        validation
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        validation
            .bind(to: nameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe { _ in
                self.present(ReactiveViewController(), animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
 

}

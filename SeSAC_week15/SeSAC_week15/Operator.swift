//
//  Operator.swift
//  SeSAC_week15
//
//  Created by kokojong on 2022/01/03.
//

import UIKit
import RxSwift

enum Exerror: Error {
    case fail
}

class Operator: UIViewController {

    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Observable : Create -> Subscribe -> next -> completed or error -> (?) disposed
        // disposed: deinit 이 될 때 데이터를 정리해줌
        
        // create
        Observable.from(["가","나","다","라","마"])
        // subscribe, next completed, error, disposed
            .subscribe { value in
                print("next: \(value)")
            } onError: { value in
                print("error: \(value)")
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("onDisposed")
            }.disposed(by: disposeBag) // 이부분을 안써도 dispose되긴 하는데 왜쓸까?
            //
        
        let repeateObservable = Observable.repeatElement("jack")
            .take(10)
            .subscribe { value in
                print("next: \(value)")
            } onError: { value in
                print("error: \(value)")
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("repeat onDisposed")
            }

        let intervalObservable = Observable<Int>.interval(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("next: \(value)")
            } onError: { value in
                print("error: \(value)")
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("interval onDisposed")
            }
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.navigationController?.pushViewController(GradeCalculator(), animated: true)
//            self.present(GradeCalculator(),animated: true,completion: nil)
//            self.dismiss(animated: true, completion: nil)
//            intervalObservable.dispose()
            
            self.disposeBag = DisposeBag() // 한번에 모든 옵저버블을 정리(초기화를 해주는 것 만으로 가능)
            
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // take로 횟수를 정해주지 않는다면 너무 많이 호출
//            repeateObservable.dispose()
        }
        
       
    }
    // 발생하지 않음
    deinit{
        print("Operator deinit")
    }
    
    
    // 1.3(월) 에 한거
    func firstFunc () {
        let items = [3.3, 4.0, 1.5, 3.9, 3.0]
        let items2 = [1.0, 2.0, 3.0]
        
        // just는 1개만 전달 가능
        Observable.just(items)
            .subscribe { value in
                print("just - \(value)")
            }
//            } onError: { error in
//                print(error)
//            } onCompleted: {
//                print("onCompleted")
//            } onDisposed: {
//                print("onDisposed")
//            }
            .disposed(by: disposeBag)
        
        // 2개 이상의 배열도 가능
        Observable.of(items, items2)
            .subscribe { value in
                print("of - \(value)")
            }
            .disposed(by: disposeBag)
        
        // 배열의 원소 하나하나
        Observable.from(items)
            .subscribe { value in
                print("from - \(value)")
            }
            .disposed(by: disposeBag)
        
        Observable<Double>.create { observer -> Disposable in
            for i in items {
                if i < 3.0 {
                    observer.onError(Exerror.fail)
                    break
                }
                observer.onNext(i)
            }
            observer.onCompleted()
            
            return Disposables.create()
        }
        .subscribe { value in
            print(value)
        } onError: { error in
            print(error)
        } onCompleted: {
            print("onCompleted")
        } onDisposed: {
            print("onDisposed")
        }
        .disposed(by: disposeBag)
    }
    
}

//
//  Subject.swift
//  SeSAC_week15
//
//  Created by kokojong on 2022/01/04.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class Subject: UIViewController {
    
    let label = UILabel()
    let disposeBag = DisposeBag()
//    let nickname = Observable.just("jack")
    let nickname = PublishSubject<String>()
    
    // 초기값을 가지지 않아도 괜춘
    let subject = PublishSubject<[Int]>()
    let array1 = [1,1,1,1,1,1]
    let array2 = [2,2,2,2,2,2]
    let array3 = [3,3,3,3,3,3]
    
    // 초기값을 가져야함
    let behavior = BehaviorSubject<[Int]>(value: [0,0,0,0,0,0])
    
    // 미리 가지고 있을 수 있는 최대크기를 가진다
    let replay = ReplaySubject<[Int]>.create(bufferSize: 3) // bufferSize: 메모리에 저장된다
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = .white
        
        let random1 = Observable<Int>.create { observer in
            observer.onNext(Int.random(in: 1...100))
            observer.onNext(Int.random(in: 1...100))
            observer.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }
        
        random1
            .subscribe { value in
                print("ran1: \(value)")
            }.disposed(by: disposeBag)
        
        random1
            .subscribe { value in
                print("ran2: \(value)")
            }.disposed(by: disposeBag)
        
        let randomSubject = BehaviorSubject(value: 0)
        randomSubject.onNext(Int.random(in: 1...100))
        
        
        // randomSubject1, 2가 똑같이 나온다.
        // Subject는 구독하는 부분을 공유한다(자원낭비나 겹치는? 오류를 없애기 위해서)
        randomSubject
            .subscribe { value in
                print("randomSubject1: \(value)")
            }.disposed(by: disposeBag)
        
        randomSubject
            .subscribe { value in
                print("randomSubject2: \(value)")
            }.disposed(by: disposeBag)
        
    }
    
    func replaySubject() {
        // 가장 최신것 기준으로 버퍼 사이즈만큼 가진다. (큐처럼)
        replay.onNext(array1)
        replay.onNext(array2)
        replay.onNext(array3)
        replay.onNext(array3)
        
        replay
            .subscribe { value in
                print("value \(value)")
            } onError: { error in
                print("error \(error)")
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("onDisposed")
            }.disposed(by: disposeBag)
        // 얘는 미리
        replay.onNext([4,4,4,4])
        replay.onNext([4,4,4,4])
        replay.onNext([4,4,4,4])
        replay.onNext([4,4,4,4])
    }
    
    func behaviorSubject() {
        // array2 가 나온다(구독하기 전인데도!) -> 구독하기 전 마지막 이벤트가 초기값으로 저장된다
        behavior.onNext(array1)
        behavior.onNext(array2)
        
        // next가 없어도 구독하면 초기값이 나온다
        behavior
            .subscribe { value in
                print("value \(value)")
            } onError: { error in
                print("error \(error)")
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("onDisposed")
            }.disposed(by: disposeBag)
        
        behavior.onNext(array3)
    }
    
    func publishSubject() {
        
        // 구독 전이라 이벤트 전달X
        subject.onNext(array1)
            
        subject.subscribe { value in
            print("value \(value)")
        } onError: { error in
            print("error \(error)")
        } onCompleted: {
            print("onCompleted")
        } onDisposed: {
            print("onDisposed")
        }.disposed(by: disposeBag)

        subject.onNext(array2)
        subject.onNext(array3)
        subject.onCompleted() // 완료가 되면 dispose까지 호출된다
        
        // 이미 완료되어서 dispose 되었기 때문에 공허한 외침ㅋㅋㅋ
        subject.onNext(array1)
        
    }
    
    func subjectFunc() {
        setup()
        
        nickname
            .bind(to: label.rx.text) // subscribe VS bind (+drive 라는거도 존재함) -> error, completion 에 대한 차이 
            .disposed(by: disposeBag)
        
//        nickname = "kokojong"
        // 옵저버블은 전달만 가능하지 바꿀수가 없다 -> 그럼 어떻게 바꾸나?
        // 옵저버와 옵저버블의 역할을 모두 하는 subject
        nickname.onNext("kokojong")
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            self.nickname.onNext("jack")
        }
    }
    
    func setup() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.backgroundColor = .lightGray
        label.textAlignment = .center
    }
}

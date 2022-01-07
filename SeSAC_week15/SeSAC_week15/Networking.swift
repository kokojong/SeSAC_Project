//
//  Networking.swift
//  SeSAC_week15
//
//  Created by kokojong on 2022/01/04.
//

import Foundation
import UIKit
import RxSwift
import RxAlamofire

struct Aztro {
    // 여기에 어떤걸 받을지 적어준다면
    // <AZtro> 로 사용도 가능
}

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

class Networking: UIViewController {
    
    let urlString = "https://aztro.sameerkumar.website?sign=taurus&day=today"
    let lottoUrl = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=990"
    
    let disposeBag = DisposeBag()
    
    let label = UILabel()
    
    let number = BehaviorSubject<String>(value: "오늘의 숫자눈!")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        label.backgroundColor = .yellow
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
     
        
        number
            .bind(to: label.rx.text)
//            .observe(on: MainScheduler.instance) // observe on vs subsribe on
//            .subscribe { value in
//                print(value)
//                self.label.text = value
//            }
            .disposed(by: disposeBag)
//            .subscribe(<#T##on: (Event<String>) -> Void##(Event<String>) -> Void#>)
        number
            .subscribe { value in
            print(value)
//                self.label.text = value
        }

          
    
        let request = useURLSession()
//            .share() // stream을 공유하게 한다 (구독을 공유한다)
            .decode(type: Lotto.self, decoder: JSONDecoder())
        
        request
            .subscribe { value in
                print("value1")
            }

//            .subscribe { value in
//                print("value1")
//            }
            .disposed(by: disposeBag)
        
        request
            .subscribe { value in
                print("value2")
            }
            .disposed(by: disposeBag)
        
        
        useURLSession()
            .decode(type: Lotto.self, decoder: JSONDecoder())
            .subscribe { value in
                print("value:",value)
//                print(Thread.isMainThread)
                // 왜 안될까
//                self.number.onNext(value.drwNoDate)
                
            }
            .disposed(by: disposeBag)
        
    }
    
    func rxAlamofire() {
        
//        json(.get, lottoUrl)
//            .subscribe { value in
//                print("value \(value)")
//            } onError: { error in
//                print("error \(error)")
//            } onCompleted: {
//                print("onCompleted")
//            } onDisposed: {
//                print("onDisposed")
//            }.disposed(by: disposeBag)
        
        // RxSwift 6부터 디코딩 연산자가 추가되어따
        // JSONSerialization: 제이슨을 하나씩 파고드는 느낌
        
        
        json(.post, urlString)
            .subscribe { value in
                print("value \(value)")
                guard let data = value as? [String: Any] else { return }
                guard let result = data["lucky_number"] as? String else { return }
                print("result : \(result)")
                self.number.onNext(result)
                
                
            } onError: { error in
                print("error \(error)")
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("onDisposed")
            }.disposed(by: disposeBag)
    }
    
    
    func useURLSession() -> Observable<Data> {
 
        return Observable.create { value in
            let url = URL(string: self.lottoUrl)!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
//                    value.onError(ExampleError.fail)
                    return
                    
                }
                
                // response 생략
                if let data = data, let json = String(data:data, encoding: .utf8){
                    print("dataTask")
                    return value.onNext(data)
                }
                
                value.onCompleted()
                
            }
            task.resume()
            
            return Disposables.create(){
                task.cancel()
            }
        }
    }
}

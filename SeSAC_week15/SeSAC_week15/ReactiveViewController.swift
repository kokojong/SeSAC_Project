//
//  ReactiveViewController.swift
//  SeSAC_week15
//
//  Created by kokojong on 2022/01/05.
//

import UIKit
import RxSwift
import RxCocoa

struct SampleData {
    var user: String
    var age: Int
    var rate: Double
}

class ReactiveViewModel {
    
    var data = [
        SampleData(user: "jack", age: 32, rate: 5.0),
        SampleData(user: "hue", age: 40, rate: 4.0),
        SampleData(user: "kokojong", age: 29, rate: 4.9)
    ]
    
//    var list = PublishSubject<[SampleData]>()
    var list = PublishRelay<[SampleData]>()
    // Relay는 서브젝트와 동일하나 completed, error를 받지 않고(disposed가 나오지 않는다 -> deinit을 직접 해줘야한다)
    // next대신에 accept를 한다
    
    func fetchData() {
        list.accept(data) // self.list = data
    }
    
    func filterData(query: String) {
        let result = query != "" ? data.filter{ $0.user.contains(query)} : data
        list.accept(result)
        
    }
}

class ReactiveViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let resetButton = UIButton()
    
    let viewModel = ReactiveViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        
//        tableView.dataSource = self
//        tableView.delegate = self
        
        // viewmodel의 data -> tableview
//        viewModel.data
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        viewModel.list
        // bind -> drive로 변경 (ui를 뿌리기만해서 적합한거로 바꾼거)
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row,  element, cell) in
//                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element.user), \(element.age)세, \(element.rate)점"
                
            }
            
            .disposed(by: disposeBag)
        
        resetButton
            .rx.tap
            .subscribe { _ in // Backward matching of the unlabeled trailing closure is deprecated; label the argument with 'onDisposed' to suppress this warning 찾아보기
                print("click")
                self.viewModel.fetchData()
            }.disposed(by: disposeBag)
   
        searchBar
            .rx.text // 서치바에 텍스트가 변경이 될 때 이벤트 발생
            .orEmpty // 옵셔널을 처리해줌(옵셔널 해제)
            // 5밀리 세컨드 동안 기다리기(계속 입력하는데 계속 불러오면 너무 많으니까 -> 멈추고 500ms 지나면 호출되도록
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            // 잘못써서 다시 원래 값으로 돌아오면 호출 안하기 (같은 값을 받지 않음)
            .distinctUntilChanged()
            //
            .subscribe { value in
                print(value)
                self.viewModel.filterData(query: value.element ?? "")
                
            }
            .disposed(by: disposeBag)

        
    }
    func setup() {
        navigationItem.titleView = searchBar
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(resetButton)
        resetButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        resetButton.backgroundColor = .red
        
    }
    
    func reactiveTest() {
        var apple = 1
        var banana = 2
        
        print(apple + banana)
        
        let a = BehaviorSubject(value: 1)
        let b = BehaviorSubject(value: 2)
        Observable.combineLatest(a,b) { $0 + $1 }
        .subscribe {
            print($0.element ?? 0)
        }
        .disposed(by: disposeBag)

        a.onNext(11)
        b.onNext(22)
    }
    

}

//extension ReactiveViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        let row = viewModel.data[indexPath.row]
//        cell.textLabel?.text = row.user
//
//        return cell
//    }
//
//
//}

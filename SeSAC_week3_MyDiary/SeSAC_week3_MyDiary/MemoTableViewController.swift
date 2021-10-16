//
//  MemoTableViewController.swift
//  SeSAC_week3_MyDiary
//
//  Created by kokojong on 2021/10/12.
//

import UIKit

class MemoTableViewController: UITableViewController {

//    var list = [Memo](){
//
//    }
    var list : [Memo] = [] {
        didSet{ // 변경이 되는지 감시자를 붙인다
//            tableView.reloadData()
            saveData()
        }
    }
    
    @IBOutlet weak var categorySegmentControl: UISegmentedControl!
    
    @IBOutlet weak var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        UITableView.automaticDimension
//        자동으로 정렬? -> 찾아보기
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action:#selector(closeButtonClicked) )
        
        loadData()

    }
    
    @objc func closeButtonClicked () {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        // 배열에 textview에 text의 값을 추가해보기
        if let text = memoTextView.text { // optional이 해제가 된다면
//            list.append(text)
            
            let segmentIndex = categorySegmentControl.selectedSegmentIndex
            let segmentCategory = Category(rawValue: segmentIndex) ?? .others // optional 처리
            
            let memo = Memo(content: text, category: segmentCategory)
            
            list.append(memo)
            
//            tableView.reloadData() // 테이블뷰 갱신
            
            print(list)
        } else {
            print("비었따")
        }
        
//        let text = memoTextView.text
//        list.append(text)
        
    }
    
    func saveData() {
        var memo : [[String : Any]] = []
        
        for i in list {
            let data : [String : Any] = [
                "category" : i.category.rawValue,
                "content" : i.content
                
            ]
            print("data : \(data)")
            memo.append(data)
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(memo, forKey: "memoList")
        tableView.reloadData()
        
//
    }
    
    func loadData() {
        let userDefaults = UserDefaults.standard
        
        if let data = userDefaults.object(forKey: "memoList") as? [[String : Any]]{
            
            var memo = [Memo]()
            
            for datum in data {
                
                guard let category = datum["category"] as? Int else { return }
                guard let content = datum["content"] as? String else { return }
                
                let enumCategory = Category(rawValue: category) ?? .others
                
                memo.append(Memo(content: content, category: enumCategory))
                
            }
            
            self.list = memo // 옵저버가 있어서 갱신이 되게함
            
        }
    }
    
    
    
    // (옵션) 섹션의 수 numberOfSections (default가 1)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    // (옵션) 섹션의 타이틀 titleForHeaderInSection
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "섹션 타이틀"
    }
    
    // 1. (필수) 셀의 갯수 numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 100 // 셀이 100개 필요하다
//        if section == 0 {
//            return 2
//        } else {
//            return 4
//        }
        return section == 0 ? 2 : list.count // 배열의 크기만큼
    }
    
    // 2. (필수) 셀의 디자인 및 데이터 처리 cellForRowAt
    // 재사용 메커니즘, 옵셔널 체이닝, 옵셔널 바인딩
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        // Early Exit -> nil 이 등장하면 빠르게 리턴
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") else {
            return UITableViewCell() // 비어있는 인스턴스
        }
        
        if indexPath.section == 0 {
            
            cell.textLabel?.text = "첫번째 섹션입니다 -\(indexPath)"
            cell.textLabel?.textColor = .brown
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            cell.imageView?.image = nil
            cell.detailTextLabel?.text = nil
            
        } else {
            
            let row = list[indexPath.row]
            
            cell.textLabel?.text = list[indexPath.row].content
            cell.detailTextLabel?.text = list[indexPath.row].category.description
            // basic은 detail이 없기 때문에 안나옴 -> 속성 바꿔주면 된다
            cell.textLabel?.textColor = .red
            cell.textLabel?.font = .italicSystemFont(ofSize: 20)
            
            switch row.category {
            case .business : cell.imageView?.image = UIImage(systemName: "building.2")
            case .personal : cell.imageView?.image = UIImage(systemName: "person")
            case .others : cell.imageView?.image = UIImage(systemName: "square.and.pencil")
            }
            
            cell.imageView?.tintColor = .red
        }
        
        
        return cell
    }
    
    // 3. (옵션이지만 필수처럼 쓰자) 셀의 높이 heightForRowAt
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80 // 셀의 높이가 80 default 가 44
//        return indexPath.section == 0 ? 44 : 80
        return indexPath.row == 0 ? 44 : 80
        // row, section별로 조절이 가능하다
        
    }
    
    // (옵션) 셀 스와이프 ON editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        
        if editingStyle == .delete && indexPath.section == 1 {
            list.remove(at: indexPath.row)
//            tableView.reloadData() // 갱신 필수
        }
    }
    
    // (옵션) 셀 스와이프 ON / OFF 여부 : canEditRowAt
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0  ? false : true
    }
    
    // (옵션) 셀을 클릭했을 때의 기능
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath) 선택")
    }
}

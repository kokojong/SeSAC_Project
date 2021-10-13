//
//  MemoTableViewController.swift
//  SeSAC_week3_MyDiary
//
//  Created by kokojong on 2021/10/12.
//

import UIKit

class MemoTableViewController: UITableViewController {

    var list : [String] = ["장 보기", "메모메모", "영화 보러 가기", "WWDC 시청하기"] {
        didSet{ // 변경이 되는지 감시자를 붙인다
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        // 배열에 textview에 text의 값을 추가해보기
        if let text = memoTextView.text { // optional이 해제가 된다면
            list.append(text)
//            tableView.reloadData() // 테이블뷰 갱신
            
            print(list)
        } else {
            print("비었따")
        }
        
//        let text = memoTextView.text
//        list.append(text)
        
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
            
        } else {
            
//            if indexPath.row == 0 {
//                cell?.textLabel?.text = list[indexPath.row]
//            } else if indexPath.row == 1 {
//                cell?.textLabel?.text = list[indexPath.row]
//            } else if indexPath.row == 2 {
//                cell?.textLabel?.text = list[indexPath.row]
//            } else if indexPath.row == 3 {
//                cell?.textLabel?.text = list[indexPath.row]
//            } else {
//                cell?.textLabel?.text = "데이터 없음"
//            }
            cell.textLabel?.text = list[indexPath.row]
            cell.textLabel?.textColor = .red
            cell.textLabel?.font = .italicSystemFont(ofSize: 20)
            
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

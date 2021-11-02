//
//  Case2TableViewController.swift
//  SeSAC_week3_MyDiary
//
//  Created by kokojong on 2021/10/12.
//

import UIKit

class Case2TableViewController: UITableViewController {

    var totalSettingList : [String] = ["공지사항", "실험실", "버전 정보"]
    var privateSettingList : [String] = ["개인/보안", "알림", "채팅", "멀티프로필"]
    var etcList : [String] = ["고객센터/도움말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // 필수 1 셀의 갯수 (섹션당 셀의 갯수)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 : return totalSettingList.count
        case 1 : return privateSettingList.count
        case 2 : return etcList.count
            // 하드코딩(3, 4, 1)에서 list의 크기로 변경함
        default:
            return 1
        }
        
    }
    
    // 필수2 셀의 디자인 및 데이터 처리 cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell") else {
            return UITableViewCell() // 비어있는 인스턴스
        }
        
        
        switch indexPath.section {
        case 0 : cell.textLabel?.text = totalSettingList[indexPath.row]
        case 1 : cell.textLabel?.text = privateSettingList[indexPath.row]
        case 2 : cell.textLabel?.text = etcList[indexPath.row]
        default:
            cell.textLabel?.text = "오류"
        }
        
        cell.textLabel?.textColor = .white // 공통
        
        return cell
        
        
    }
    
    // 전체 섹션의 수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    // 섹션의 타이틀
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 : return "전체 설정"
        case 1 : return "개인 설정"
        case 2 : return "기타"
        default : return "오류"

        }
    }
    
    // 셀의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return indexPath.row == 0 ? 44 : 80
        return 44 // 다 똑같이 44로 고정
    }


}

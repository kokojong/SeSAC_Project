//
//  SearchViewController.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!
//    var tasks =
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchTableView.estimatedRowHeight = 150
        searchTableView.rowHeight = UITableView.automaticDimension
        
        title = NSLocalizedString("searchTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
     
        tasks = localRealm.objects(UserDiary.self)
        print(tasks)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTableView.reloadData()
    }
    
    
    // 도큐먼트 폴더 경로 -> 이미지 찾기 -> UIImage -> UIImageView
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
    
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        
        return nil
    }
    
    func deleteImageFromDocumentDirectory(imageName: String) {
        
        // 1. 이미지를 저장할 경로 설정하기: 도큐먼트 폴더, FilManager
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 이미지 파일 이름 & 최종 경로 설정
        // Desktop/jack/ios/folder/100.png 이런식
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
//        // 3. 이미지 압축 - 여기서는 필요없음
//        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        // 4. 이미지 저장: 동일한 경로에 이미지를 저장하게 된 경우, 덮어쓰기가 된다
        // 4-1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            
            // 4-2. 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지 삭제 에러")
            }
        }
        
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        try! localRealm.write{
        
            // 순서를 잘 생각하자! reaml에서 먼저 지우면 index오류가 발생한다.
            deleteImageFromDocumentDirectory(imageName: "\(tasks[indexPath.row]._id).jpg")
            localRealm.delete(tasks[indexPath.row])
            
            tableView.reloadData()
            
        }
        
    }
    
    // 원래는 화면을 전환해서 값전달후 새로운 화면에서 수정하는 것이 적합함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Search", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        let row = tasks[indexPath.row]
        
        vc.task = row
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        // realm에 대한 값 수정
//        let taskToUpdate = tasks[indexPath.row]
        
        // 1. 수정 - 레코드에 대한 값 수정
//        try! localRealm.write {
//            taskToUpdate.diaryTitle = "title 수정"
//            taskToUpdate.diaryContent = "content 수정"
//            searchTableView.reloadData()
//
//        }
//        // 2. 일괄 수정
//        try! localRealm.write {
//            tasks.setValue(Date(), forKey: "diaryDate")
//            tasks.setValue("새롭게 일기 쓰기", forKey: "diaryTitle")
//            tableView.reloadData()
//        }
        
        // 3. 수정 -> 지정한 것 이외에는 다 nil로 초기화가 되어버림 -> 내용 같은게 날아감
//        try! localRealm.write {
//            let update = UserDiary(value: ["_id" : taskToUpdate._id, "diaryTitle": "얘만 바꿀랭"] )
//            localRealm.add(update, update: .modified)
//            tableView.reloadData()
//        }
        
        // 4. 특정 요소만 업데이트 해주고 나머지는 유지해줌
//        try! localRealm.write {
//            localRealm.create(UserDiary.self, value: ["_id" : taskToUpdate._id, "diaryTitle": "얘만 바꿀랭"], update: .modified)
//            tableView.reloadData()
//        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        let row = tasks[indexPath.row]
        
        cell.titleLabel.text = row.diaryTitle
        cell.titleLabel.font = UIFont().mainBlack
        cell.dateLabel.text = "\(row.diaryDate)"
//        cell.mainImageView.image = UIImage(systemName: "person")
        cell.mainImageView.image = loadImageFromDocumentDirectory(imageName: "\(row._id).jpg")
        cell.contentLabel.text = row.diaryContent
        
        return cell
        
        
    }
    
    
}

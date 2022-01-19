//
//  ShoppingListTableViewController.swift
//  SeSAC_week3_MyDiary
///Users/mac/Desktop/SSAC/SeSAC_week3_MyDiary/ShoppingListTableViewCell.swift
//  Created by kokojong on 2021/10/13.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    @IBOutlet weak var mainTextField: UITextField!
    
//    var shoppingList : [String] = ["그립톡 사기", "사이다 사기", "아이패드 사기", "아이폰 사기"] {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
    var shoppingList : [ShoppingList]  = [
        ShoppingList(content: "아이폰 사기", checkbox: 0 , bookmark: 0),
        ShoppingList(content: "맥북 사기", checkbox: 0 , bookmark: 0),
        ShoppingList(content: "내용이 많다면내용이 많다면내용이 많다면내용이 많다면내용이 많다면내용이 많다면 ", checkbox: 0, bookmark: 0)
    ]{
        didSet{
//            tableView.reloadData()
            saveData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        
        loadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath) as? ShoppingListTableViewCell else {
            return UITableViewCell()
        }
     
        cell.shoppingListLabel?.text = shoppingList[indexPath.row].content // 쇼핑 목록의 content 값을 넣어줌
        cell.shoppingListLabel?.textColor = .white
        cell.shoppingListLabel?.font = .italicSystemFont(ofSize: 15)
        
        
        
        
//        if indexPath.row == 2 {
//            cell.checkBoxButton.setImage(UIImage(systemName: "heart"), for: .normal)
//            cell.checkBoxButton.image = UIImage(named: "checkmark.square.fill")
//            cell.checkBoxButton.currentImage = UIImage(named: "checkmark.square.fill")
//            cell.checkBoxButton.setImage(UIImage.init(named: "checkmark.square.fill"), for: .normal)
//        }
        
        
        return cell
        
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
// 

    
    // (옵션) 셀 스와이프 ON editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
        }
    }
    
    // (옵션) 셀 스와이프 ON / OFF 여부 : canEditRowAt
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func onSaveButtonClicked(_ sender: UIButton) {
        if let text = mainTextField.text { // optional이 해제가 된다면
            
            let shopping = ShoppingList(content: text, checkbox: 0, bookmark: 0)
            
            shoppingList.append(shopping)
            
            
        } else {
            print("비었따")
        }
        
    
    }
    
    func saveData() {
        var shopping : [[String : Any]] = []
        
        for i in shoppingList {
            let data : [String : Any] = [
                "content" : i.content,
                "checkbox" : i.checkbox,
                "bookmark" : i.bookmark
            ]
            
            shopping.append(data)
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(shopping, forKey: "shoppingList")
        tableView.reloadData()
        
//        let category = JobCategory(id: 1, name: "Test Category", URLString: "http://www.example-job.com")
//        let encodedData = NSKeyedArchiver.archivedData(withRootObject: category, requiringSecureCoding: false)
//        let userDefaults = UserDefaults.standard
//        userDefaults.set(encodedData, forKey: UserDefaultsKeys.jobCategory.rawValue)
        
//        let encoded = NSKeyedArchiver.archivedData(withRootObject: shopping, requiringSecureCoding: false)
//        userDefaults.set(encoded, forKey: "shoppintList")
        
    }
    
    func loadData() {
        let userDefaults = UserDefaults.standard
        
        if let data = userDefaults.object(forKey: "shoppingList") as? [[String : Any]]{
            
            var shopping = [ShoppingList]()
            
            for datum in data {
                
//                guard let category = datum["category"] as? Int else { return }
//                guard let content = datum["content"] as? String else { return }
                
                guard let content = datum["content"] as? String else { return }
                guard let checkbox = datum["checkbox"] as? Int else { return }
                guard let bookmark = datum["bookmark"] as? Int else { return }
                
//                let enumcheckbox = CheckBox(rawValue: checkbox) ?? .unchecked
//                let enumCheckbox = CheckBox(rawValue: checkbox) ?? .unchecked
//                let enumbookmark = BookMark(rawValue: bookmark) ?? .unmarked

                
//                let enumCategory = Category(rawValue: category) ?? .others
                
                shopping.append(ShoppingList(content: content, checkbox: checkbox, bookmark: bookmark))
                
            }
            
            self.shoppingList = shopping// 옵저버가 있어서 갱신이 되게함
            
        }
    }
    
}

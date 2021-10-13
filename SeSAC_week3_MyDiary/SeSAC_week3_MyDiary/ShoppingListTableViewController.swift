//
//  ShoppingListTableViewController.swift
//  SeSAC_week3_MyDiary
///Users/mac/Desktop/SSAC/SeSAC_week3_MyDiary/ShoppingListTableViewCell.swift
//  Created by kokojong on 2021/10/13.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    @IBOutlet weak var mainTextField: UITextField!
    
    var shoppingList : [String] = ["그립톡 사기", "사이다 사기", "아이패드 사기", "아이폰 사기"] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath) as? ShoppingListTableViewCell else {
            return UITableViewCell()
        }
     
        cell.shoppingListLabel?.text = shoppingList[indexPath.row]
        cell.shoppingListLabel?.textColor = .white
        cell.shoppingListLabel?.font = .italicSystemFont(ofSize: 15)
        
        if indexPath.row == 2{
//            cell.checkBoxButton.image = UIImage(named: "checkmark.square.fill")
//            cell.checkBoxButton.currentImage = UIImage(named: "checkmark.square.fill")
            cell.checkBoxButton.setImage(UIImage.init(named: "checkmark.square.fill"), for: .normal)
        }
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
 

    
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
            shoppingList.append(text)
        } else {
            print("비었따")
        }
    }
}

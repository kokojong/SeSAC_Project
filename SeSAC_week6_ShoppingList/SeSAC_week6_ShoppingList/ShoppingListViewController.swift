//
//  ShoppingListViewController.swift
//  SeSAC_week6_ShoppingList
//
//  Created by kokojong on 2021/11/02.
//

import UIKit
import RealmSwift

class ShoppingListViewController: UIViewController {

    @IBOutlet weak var shoppingTableView: UITableView!
    
    @IBOutlet weak var shoppingTextField: UITextField!
    
    var shoppingList: Results<ShoppingList>!
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shoppingTableView.delegate = self
        shoppingTableView.dataSource = self
        
        print("Realm:",localRealm.configuration.fileURL!)
        
        shoppingList = localRealm.objects(ShoppingList.self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        shoppingTableView.reloadData()
    }
    
    @IBAction func onAddButtonClicked(_ sender: UIButton) {
        
        let task = ShoppingList(itemName: shoppingTextField.text!)
        try! localRealm.write {
            localRealm.add(task)
        }
        
        shoppingTableView.reloadData()
        
    }
    
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = shoppingTableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier) as? ShoppingListTableViewCell else {
            return UITableViewCell()
        }
        
        let row = shoppingList[indexPath.row]
        
        cell.shoppingLabel.text = row.itemName
        
        if row.check == 0 {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
        
        if row.bookmark == 0 {
            cell.bookMarkButton.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            cell.bookMarkButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        
        cell.checkButton.tag = indexPath.row
        cell.bookMarkButton.tag = indexPath.row
        
        cell.checkButton.addTarget(self, action: #selector(onCheckButtonClicked(selected:)), for: .touchUpInside)
        
        cell.bookMarkButton.addTarget(self, action: #selector(onBookmarkButtonClicked(selected:)), for: .touchUpInside)
        
        return cell
        
        
    }
    
    @objc func onCheckButtonClicked(selected: UIButton) {
        print("check")
        
        // All modifications to a realm must happen in a write block.
        let taskToUpdate = shoppingList[selected.tag]
        try! localRealm.write {
            taskToUpdate.check = (taskToUpdate.check + 1) % 2
        }
        shoppingTableView.reloadData()
        
    }
    
    @objc func onBookmarkButtonClicked(selected: UIButton) {
        print("bookmark")
        
        let taskToUpdate = shoppingList[selected.tag]
        try! localRealm.write {
            taskToUpdate.bookmark = (taskToUpdate.bookmark + 1) % 2
        }
        shoppingTableView.reloadData()
        
    }
    
    
    
    
    
    
}

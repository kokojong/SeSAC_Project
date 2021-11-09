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
    
    var tasks: Results<ShoppingList>!
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shoppingTableView.delegate = self
        shoppingTableView.dataSource = self
        
        print("Realm:",localRealm.configuration.fileURL!)
        
        tasks = localRealm.objects(ShoppingList.self)
        
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
    
    @IBAction func onSortButtonClicked(_ sender: UIButton) {
        
        // 1. UIAlertController 생성 : 밑바탕 + 타이틀 + 본문
        let alert = UIAlertController(title: "정렬하기", message: "아래의 정렬 방식 중 한 가지를 골라주세요", preferredStyle: .actionSheet)
        // 2. UIAlertAction 생성 : 버튼들을 만들어준다
        let check = UIAlertAction(title: "완료된 순으로 정렬", style: .default) { action in
            let sortedByCheck = self.tasks.sorted(byKeyPath: "check", ascending: false)
            self.tasks = sortedByCheck
           
            self.shoppingTableView.reloadData()
        }
        
        let item = UIAlertAction(title: "이름 순(오름차순)으로 정렬", style: .default) { action in
            let sortedByName = self.tasks.sorted(byKeyPath: "itemName", ascending: true)
            self.tasks = sortedByName
            
            self.shoppingTableView.reloadData()
        }
        let bookmark = UIAlertAction(title: "즐겨찾기 순으로 정렬", style: .default) { action in
            let sortedBybookmark = self.tasks.sorted(byKeyPath: "bookmark", ascending: false)
            self.tasks = sortedBybookmark
            
            self.shoppingTableView.reloadData()
        }
        
        // 3. 1과 2를 합쳐준다
        // addAction의 순서대로 버튼이 붙는다
        alert.addAction(check)
        alert.addAction(item)
        alert.addAction(bookmark)
        
        // 4. Present (보여줌) - modal처럼
        present(alert, animated: true, completion: nil)
        
    }
    
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = shoppingTableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier) as? ShoppingListTableViewCell else {
            return UITableViewCell()
        }
        
        
        let row = tasks[indexPath.row]
        
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
        let taskToUpdate = tasks[selected.tag]
        try! localRealm.write {
            taskToUpdate.check = (taskToUpdate.check + 1) % 2
        }
        shoppingTableView.reloadData()
        
    }
    
    @objc func onBookmarkButtonClicked(selected: UIButton) {
        print("bookmark")
        
        let taskToUpdate = tasks[selected.tag]
        try! localRealm.write {
            taskToUpdate.bookmark = (taskToUpdate.bookmark + 1) % 2
        }
        shoppingTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        try! localRealm.write {
            
            localRealm.delete(tasks[indexPath.row])
            tableView.reloadData()
            
        }
        
    }

}

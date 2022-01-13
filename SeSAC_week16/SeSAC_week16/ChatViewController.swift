//
//  ChatViewController.swift
//  SeSAC_week16
//
//  Created by kokojong on 2022/01/13.
//

import UIKit

class ChatViewController: UIViewController {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
        
        
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        tableView.register(YourChatTableViewCell.self, forCellReuseIdentifier: YourChatTableViewCell.identifier)
    }
    

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        if indexPath.row%2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier) as! MyChatTableViewCell
            cell.chatLabel.text = "my chat"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: YourChatTableViewCell.identifier) as! YourChatTableViewCell
            cell.chatLabel.text = "your chat"
            
            return cell
        }
            
        
        
//        cell.textLabel
//        var content = cell.defaultContentConfiguration()
//        content.text = "텍스트"
//        content.image = UIImage(systemName: "heart")
//
//        cell.contentConfiguration = content
        
       
    }
    
    
}

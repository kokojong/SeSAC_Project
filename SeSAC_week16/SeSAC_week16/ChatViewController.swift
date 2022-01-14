//
//  ChatViewController.swift
//  SeSAC_week16
//
//  Created by kokojong on 2022/01/13.
//

import UIKit
import Alamofire

class ChatViewController: UIViewController {
    
    let username = "kokojong"
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZTBjNTc2YmUzNDViZDllZDBjN2NmZiIsImlhdCI6MTY0MjEyMDU2NiwiZXhwIjoxNjQyMjA2OTY2fQ.n_FkRqpY2hPLFrkyV_m7tTHsJyxCznj4yLKTuEVp6cQ"
    let url = "http://test.monocoding.com:1233/chats"
    
    let tableView = UITableView()
    
    var list: [Chat] = []
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SocketIOManager.shared.closeConnection()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        tableView.register(YourChatTableViewCell.self, forCellReuseIdentifier: YourChatTableViewCell.identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(noti:)), name: NSNotification.Name("getMessage"), object: nil)
        
        requestChats()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "보내기", style: .done, target: self, action: #selector(postchat2))
        
    }
    
    @objc func getMessage(noti: NSNotification) {
        
        let chat = noti.userInfo!["chat"] as! String
        let name = noti.userInfo!["name"] as! String
        let createdAt = noti.userInfo!["createdAt"] as! String
        
        // 모델에 추가
        let value = Chat(text: chat, userID: "", name: name, username: "", id: "", createdAt: createdAt, updatedAt: "", v: 0, lottoID: "")
        
        self.list.append(value)
        
        self.tableView.reloadData()
        self.tableView.scrollToRow(at: IndexPath(row: self.list.count-1, section: 0), at: .bottom, animated: true)
        
    }
    
    @objc func postchat2() {
        postChat()
    }
    
    
    
    // DB(last chat time) : 나중에는 DB에 기록된 채팅의 마지막 시간을 서버에 요청. 새로운 데이터만 서버에서 받아오기
    func requestChats() {
        let header: HTTPHeaders = [
            "accept" : "application/json",
            "authorization" : "Bearer \(token)"
        ]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: [Chat].self ) { response in
                switch response.result{
                case .success(let val):
                    self.list = val
                    self.tableView.reloadData()
                    self.tableView.scrollToRow(at: IndexPath(row: self.list.count-1, section: 0), at: .bottom, animated: false)
                    SocketIOManager.shared.establishConnection()
                case .failure(let error) :
                    print("error: ",error)
                    
                    
                }
            }
    }
    
    // 올리는애는 응답을 처리 안해도 된다
    func postChat() {
        let header: HTTPHeaders = [
            "accept" : "application/json",
            "authorization" : "Bearer \(token)"
        ]
        
        let array = ["코코종 사칭 금지", "코코종 사칭 금지2", "코코종 사칭 금지3", "코코종 사칭 금지4"]
        
        
        AF.request(url, method: .post, parameters: ["text" : "\(array.randomElement()!)"], encoder: JSONParameterEncoder.default, headers: header).responseString { data in
            print("post chat succeed", data)
        }
//            .responseDecodable(of: [Chat].self ) { response in
//                switch response.result{
//                case .success(let val):
//                    self.list = val
//                    self.tableView.reloadData()
//                    self.tableView.scrollToRow(at: IndexPath(row: self.list.count-1, section: 0), at: .bottom, animated: false)
//                    SocketIOManager.shared.establishConnection()
//                case .failure(let error) :
//                    print("error: ",error)
//
//
//                }
//            }
    }
    
    

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
//        if indexPath.row%2 == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier) as! MyChatTableViewCell
//            cell.chatLabel.text = list[indexPath.row].text
//
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: YourChatTableViewCell.identifier) as! YourChatTableViewCell
//            cell.chatLabel.text = "your chat"
//
//            return cell
//        }
        
        let data = list[indexPath.row]
        
        if data.name == username {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = list[indexPath.row].text
            cell.backgroundColor = .yellow
            
            var content = cell.defaultContentConfiguration()
            content.text = list[indexPath.row].text
            content.image = UIImage(systemName: "star")

            cell.contentConfiguration = content
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = list[indexPath.row].text
            
            var content = cell.defaultContentConfiguration()
            content.text = "\(list[indexPath.row].name) --- \(list[indexPath.row].text)"
            content.image = UIImage(systemName: "heart")

            cell.contentConfiguration = content
            
            return cell
            
        }
        
        
       
    }
    
    
}

struct Chat: Codable {
    let text, userID, name, username: String
    let id, createdAt, updatedAt: String
    let v: Int
    let lottoID: String

    enum CodingKeys: String, CodingKey {
        case text
        case userID = "userId"
        case name, username
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
        case lottoID = "id"
    }
}

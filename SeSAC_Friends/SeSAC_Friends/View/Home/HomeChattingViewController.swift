//
//  HomeChattingViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/17.
//

import UIKit
import SnapKit
import Then
import Alamofire

class HomeChattingViewController: UIViewController, UiViewProtocol {
    
    let mainTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.isScrollEnabled = true
    }
    
    let chatView = ChattingView().then {
        $0.textView.text = "메세지를 입력하세요"
        $0.textView.textColor = UIColor.lightGray
    }
    
    // moreButton을 누르면 열리는 뷰
    let moreView = UIView().then {
        $0.isHidden = true
    }
    
    let menuView = MenuView().then {
        $0.backgroundColor = .white
    }
    
    let darkView = UIView().then {
        $0.backgroundColor = .black?.withAlphaComponent(0.5)
    }
    
    var viewModel = HomeViewModel.shared
    
    var chatViewModel = ChatViewModel.shared

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SocketIOManager.shared.closeConnection()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        SocketIOManager.shared.establishConnection()
        
        viewModel.checkMyQueueStatus { myQueueStateResult, statuscode, error in
            
            guard let myQueueStateResult = myQueueStateResult else {
                return
            }

            self.title = myQueueStateResult.matchedNick!
            
            if myQueueStateResult.matched == 1 {
                UserDefaults.standard.set(MyStatusCase.matched.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
            }
            
            UserDefaults.standard.set(myQueueStateResult.matchedUid, forKey: UserDefaultKeys.otherUid.rawValue)
        }
        
        
        chatViewModel.chatList.bind { _ in
            self.mainTableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "채팅"
        
        addViews()
        addConstraints()
        
        setNavBackArrowButton()
        let moreButton = UIBarButtonItem(image: UIImage(named: "ellipsis.vertical"), style: .done, target: self, action: #selector(onMoreButtonClicked))
        moreButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = moreButton
        
        chatView.textView.delegate = self
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        mainTableView.register(OtherChatTableViewCell.self, forCellReuseIdentifier: OtherChatTableViewCell.identifier)
        mainTableView.register(ChattingHeaderTableViewCell.self, forCellReuseIdentifier: ChattingHeaderTableViewCell.identifier)
        
        mainTableView.estimatedRowHeight = UITableView.automaticDimension
        mainTableView.separatorStyle = .none
        
        menuView.reportButton.addTarget(self, action: #selector(reportButtonClicked), for: .touchUpInside)
        menuView.dodgeButton.addTarget(self, action: #selector(dodgeButtonClicked), for: .touchUpInside)
        menuView.rateButton.addTarget(self, action: #selector(rateButtonClicked), for: .touchUpInside)
        
        // MARK: 채팅
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(noti:)), name: NSNotification.Name("getMessage"), object: nil)
        
        chatView.sendMessageButton.addTarget(self, action: #selector(sendMessageButtonClicked), for: .touchUpInside)
        
        requestChats()
        
        print("otherUid: ",UserDefaults.standard.string(forKey: UserDefaultKeys.otherUid.rawValue)!)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    func addViews() {
        view.addSubview(mainTableView)
        view.addSubview(chatView)
        view.addSubview(moreView)
        moreView.addSubview(menuView)
        moreView.addSubview(darkView)
    }
    
    func addConstraints() {
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        chatView.snp.makeConstraints { make in
            make.top.equalTo(mainTableView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        moreView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(mainTableView)
            make.bottom.equalToSuperview()

        }
        
        menuView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(72)
        }
        
        darkView.snp.makeConstraints { make in
            make.top.equalTo(menuView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func requestChats() {
        print(#function)

        chatViewModel.recieveMessage(lastchatDate: self.chatViewModel.tmpLastChatDate,from: UserDefaults.standard.string(forKey: UserDefaultKeys.otherUid.rawValue)! ) { chats, statuscode in
            print("requestChats",statuscode)
            
            switch statuscode {
            case ChatStatusCodeCase.success.rawValue:
                guard let chats = chats else {
                    return
                }
                print(chats)
                
                self.mainTableView.reloadData()
                
                if self.chatViewModel.chatList.value.count > 0 {
                    self.mainTableView.scrollToRow(at: IndexPath(row: self.chatViewModel.chatList.value.count-1, section: 1), at: .bottom, animated: false)
                }
                
            default:
                self.view.makeToast("채팅 내역을 불러오는데 실패했습니다")
            }
            
        }
        
       
        
    }
    
    // 올리는애는 응답을 처리 안해도 된다
    func postChat(chat: String) {
        print(#function)
        
        chatViewModel.sendMessage(chat: chat, to: UserDefaults.standard.string(forKey: UserDefaultKeys.otherUid.rawValue)!) { chat, statuscode in

            switch statuscode {
            case ChatStatusCodeCase.success.rawValue:
                print("success")
                // 보내고 -> 다시 데이터 불러오기
                self.requestChats()
            case ChatStatusCodeCase.fail.rawValue:
                self.view.makeToast("매칭이 해제된 상태입니다.")
                
            default:
                self.view.makeToast("메세지 전송에 실패했습니다.")
            }
        }
    }
    
    
    @objc func getMessage(noti: NSNotification) {
        print(#function)
        
        let from = noti.userInfo!["from"] as! String
        let to = noti.userInfo!["to"] as! String
        let chat = noti.userInfo!["chat"] as! String
        let id = noti.userInfo!["_id"] as! String
        let createdAt = noti.userInfo!["createdAt"] as! String
        let v = noti.userInfo!["__v"] as! Int
        
        // 뷰모델에 추가
        let value = Chat(from: from, to: to, chat: chat, id: id, createdAt: createdAt, v: v)
        
        self.chatViewModel.chatList.value.append(value)

        self.mainTableView.reloadData()
        if self.chatViewModel.chatList.value.count > 0 {
            self.mainTableView.scrollToRow(at: IndexPath(row: self.chatViewModel.chatList.value.count-1, section: 1), at: .bottom, animated: false)
        }
        
    }
    
    
    @objc func onMoreButtonClicked() {
        moreView.isHidden.toggle()
    }
    
    @objc func reportButtonClicked() {
        moreView.isHidden.toggle()
        
        let vc = HomeChattingReportViewController()
        vc.modalTransitionStyle = . crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
        
    }
    
    @objc func dodgeButtonClicked() {
        moreView.isHidden.toggle()
        
        let vc = HomeChattingDodgeViewController()
        vc.modalTransitionStyle = . crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @objc func rateButtonClicked() {
        moreView.isHidden.toggle()
        
        let vc = HomeChattingRateViewController()
        vc.modalTransitionStyle = . crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
        
    }
    
    @objc func sendMessageButtonClicked() {
        // 가능할때만 (빈 채팅 or placeholder 안보내기)
        if chatView.sendMessageButton.image(for: .normal) == UIImage(named: "sendButton_fill") {
            postChat(chat: chatView.textView.text)
            chatView.sendMessageButton.setImage(UIImage(named: "sendButton"), for: .normal)
            chatView.textView.text = ""
            view.endEditing(true)
            requestChats()
        }
    }
    
}

extension HomeChattingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return chatViewModel.chatList.value.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingHeaderTableViewCell.identifier, for: indexPath) as? ChattingHeaderTableViewCell else {
                return UITableViewCell()
            }
            
            let nick = viewModel.myQueueState.value.matchedNick ?? ""
            
            cell.titleLabel.text = "\(nick)님과 매칭되었습니다"
            
            return cell
            
        } else {
            // from 나 -> 내가 보낸거
            let row = chatViewModel.chatList.value[indexPath.row]
            
            if row.from == viewModel.myUserInfo.value.uid {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier, for: indexPath) as? MyChatTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.messageLabel.text = row.chat
                cell.timeLabel.text = row.createdAt.toDate
                cell.selectionStyle = .none
                
                return cell
                
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherChatTableViewCell.identifier, for: indexPath) as? OtherChatTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.messageLabel.text = row.chat
                cell.timeLabel.text = row.createdAt.toDate
                cell.selectionStyle = .none
                
                return cell
                
            }
        }
        
    }
    
}


extension HomeChattingViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray { // TextColor로 처리합니다. text로 처리하게 된다면 placeholder와 같은걸 써버리면 동작이 이상하겠죠?
            textView.text = nil // 텍스트를 날려줌
            textView.textColor = UIColor.black
        }
    }
    
    // UITextView의 placeholder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메세지를 입력하세요"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray || textView.text.count == 0 {
            chatView.sendMessageButton.setImage(UIImage(named: "sendButton"), for: .normal)
        } else {
            chatView.sendMessageButton.setImage(UIImage(named: "sendButton_fill"), for: .normal)
        }
        
        let contentHeight = textView.contentSize.height
        DispatchQueue.main.async {
            if contentHeight <= 20 {
                self.chatView.textView.snp.updateConstraints {
                    $0.height.equalTo(16)
                }
            } else if contentHeight <= 40 {
                self.chatView.textView.snp.updateConstraints {
                    $0.height.equalTo(32)
                }
            } else {
                self.chatView.textView.snp.updateConstraints {
                    $0.height.equalTo(48)
                }
            }
        }
    }
    
  
}


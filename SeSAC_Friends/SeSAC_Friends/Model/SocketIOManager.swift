//
//  SocketIOManager.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/22.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    // 서버와 메세지를 주고 받기위한 클래스
    var manager: SocketManager!
    
    // 클라이언트 소켓
    var socket: SocketIOClient!
    
    let url = URL(string: URL.baseURL)!
    
    var chatList: [Chat] = []
    
    override init() {
        super.init()
    
    
        manager = SocketManager(socketURL: url, config: [
            .log(true), // debug 가능하도록함
            .compress, // websocket 전송에서 compression을 가능하게함
            .extraHeaders([
                "idtoken": UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!]) // header를 부여
            
        ])
        
        socket = manager.defaultSocket // 디폴트로 "/" 로 된 룸
        
        // 소켓 연결 메서드(귀를 열기 전에 연결 먼저)
        socket.on(clientEvent: .connect) { data, ack in
            print("socket is connected", data, ack)
        }
        
        // 소켓 연결 해제 메서드
        socket.on(clientEvent: .disconnect) { data, ack in
            print("socket is disconnected", data, ack)
        }
        
        
        // 소켓 채팅 듣는 메서드, sesac 이벤트로 날아온 데이터를 수신
        // 데이터 수신 -> 디코딩 -> 모델에 추가 -> 갱신
        // event의 String (서버에서 미리 약속한거)
        socket.on("sesac") { dataArr, ack in
            print("sesac received", dataArr, ack)
            let data = dataArr[0] as! NSDictionary
            let from = data["from"] as! String
            let to = data["to"] as! String
            let chat = data["chat"] as! String
            let createdAt = data["createdAt"] as! String
            let id = data["id"] as! String
            let v = data["v"] as! String
            
            print("check data",from, to, chat, createdAt, id, v)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: [
                "from" : from,
                "to" : to,
                "chat" : chat,
                "createdAt" : createdAt,
                "id" : id,
                "v" : v
            ])
            
        }
        
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    
    
    
}

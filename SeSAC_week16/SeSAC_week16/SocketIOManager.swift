//
//  SocketIOManager.swift
//  SeSAC_week16
//
//  Created by kokojong on 2022/01/14.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    // 서버와 메세지를 주고 받기위한 클래스
    var manager: SocketManager!
    
    // 클라이언트 소켓
    var socket: SocketIOClient!
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZTBjNTc2YmUzNDViZDllZDBjN2NmZiIsImlhdCI6MTY0MjEyMDU2NiwiZXhwIjoxNjQyMjA2OTY2fQ.n_FkRqpY2hPLFrkyV_m7tTHsJyxCznj4yLKTuEVp6cQ"
    
    override init() {
        super.init()
        
        let url = URL(string: "http://test.monocoding.com:1233")!
        manager = SocketManager(socketURL: url, config: [
            .log(true),
            .compress,
            .extraHeaders(["auth" : token])
        ])
        
        socket = manager.defaultSocket // "/" 로 된 룸
        
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
        socket.on("sesac") { dataArr, ack in
            print("sesac received", dataArr, ack)
            let data = dataArr[0] as! NSDictionary
            let chat = data["text"] as! String
            let name = data["name"] as! String
            let createdAt = data["createdAt"] as! String
            
            print("check data",chat, name, createdAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat" : chat, "name" : name, "createdAt" : createdAt])
            
        }
        
        
        
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func sendMessage() {
//        socket.emitWithAck(<#T##event: String##String#>, with: <#T##[SocketData]#>)
    }
    
}

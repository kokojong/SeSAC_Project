//
//  ChatAPIService.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/22.
//

import Foundation
import Alamofire

class ChatAPIService {
    
    static func sendMessage(idToken: String, chat: String, to: String, completion: @escaping (Chat?, Int?) -> Void) {
        
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/json"] as HTTPHeaders
        
        let parameters = [
            "chat" : chat
        ]
        
        AF.request(ChatEndPoint.sendChat(to: to).url.absoluteString, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: Chat.self) { response in
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let chat):
                completion(chat,statusCode)
            case .failure(let error):
                completion(nil, statusCode)
                
            }
            
        }
        
    }
    
    static func recieveMessage(idToken: String, from: String, lastchatDate: String, completion: @escaping (Chats?, Int?) -> Void) {
        
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
        
        AF.request(ChatEndPoint.recieveChat(from: from, lastchatDate: lastchatDate).url.absoluteString, method: .get, headers: headers).responseDecodable(of: Chats.self) { response in
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let chat):
                completion(chat,statusCode)
            case .failure(let error):
                completion(nil, statusCode)
                
            }
            
        }
        
    }
    
}

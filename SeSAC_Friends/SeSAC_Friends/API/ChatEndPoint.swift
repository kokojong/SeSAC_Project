//
//  ChatEndPoint.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/22.
//

import Foundation

enum ChatEndPoint {
    
    case sendChat(to: String)
    case recieveChat(from: String, lastchatDate: String)
}

extension ChatEndPoint {
    var url: URL {
        switch self {
        case .sendChat(to: let to):
            return .makeChatEndPoint(to)
        case .recieveChat(from: let from, lastchatDate: let lastchatDate):
            return .makeChatEndPoint( from + "?lastchatDate=" + lastchatDate)
        }
        
    }
    
    
}

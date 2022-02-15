//
//  QueueEndPoint.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/06.
//

import Foundation

enum QueueEndPoint {
    case onQueue
    case postQueue
    case deleteQueue
    case hobbyRequest
    case hobbyAccept
    
}

extension QueueEndPoint {
    var url: URL {
        switch self {
        case .onQueue:
            return .makeQueueEndPoint("onqueue")
        case .postQueue, .deleteQueue:
            return .makeQueueEndPoint("")
        case .hobbyRequest:
            return .makeQueueEndPoint("hobbyrequest")
        case .hobbyAccept:
            return .makeQueueEndPoint("hobbyaccept")
            
        }
        
    }
}

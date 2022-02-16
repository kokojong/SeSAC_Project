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
    case myQueueState
    case writeReview(id: String)
    case dodge
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
        case .myQueueState:
            return .makeQueueEndPoint("myQueueState")
        case .writeReview(id: let id):
            return .makeQueueEndPoint("rate/\(id)")
        case .dodge:
            return .makeQueueEndPoint("dodge")
            
        }
        
    }
}

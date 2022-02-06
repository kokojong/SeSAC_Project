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
    
}

extension QueueEndPoint {
    var url: URL {
        switch self {
        case .onQueue:
            return .makeQueueEndPoint("onqueue")
        case .postQueue:
            return .makeQueueEndPoint("")
        }
        
    }
}

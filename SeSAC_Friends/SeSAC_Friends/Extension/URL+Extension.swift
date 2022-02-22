//
//  URL+Extension.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/22.
//

import Foundation

extension URL {
    static let baseURL = "http://test.monocoding.com:35484/"
    
    static func makeUserEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + "user/" + endpoint)!
    }
    
    static func makeQueueEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + "queue/" + endpoint)!
    }
    
    static func makeChatEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + "chat/" + endpoint)!
    }
}

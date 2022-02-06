//
//  EndPoint.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/20.
//

import Foundation

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum UserEndPoint {
    case getMyUserInfo
    case postMyUserInfo
    case withdrawSignUp
    case updateMypage
    case updateFCMToken
}

extension UserEndPoint {
    var url: URL {
        switch self {
        case .getMyUserInfo, .postMyUserInfo:
            return .makeUserEndPoint("")
        case .withdrawSignUp:
            return .makeUserEndPoint("withdraw")
        case .updateMypage:
            return .makeUserEndPoint("update/mypage")
        case .updateFCMToken:
            return .makeUserEndPoint("update_fcm_token")
            
        }
    }
}


extension URL {
    static let baseURL = "http://test.monocoding.com:35484/"
    
    static func makeUserEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + "user/" + endpoint)!
    }
    
    static func makeQueueEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + "queue/" + endpoint)!
    }
}

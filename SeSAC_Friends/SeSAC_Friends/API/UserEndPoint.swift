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
    case reportOtherUser
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
        case .reportOtherUser:
            return .makeUserEndPoint("report")
            
        }
    }
}




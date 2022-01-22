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

enum EndPoint {
    case getMyUserInfo
    case postMyUserInfo
    
}

extension EndPoint {
    var url: URL {
        switch self {
        case .getMyUserInfo:
            return .makeEndPoint("user")
        case .postMyUserInfo:
            return .makeEndPoint("user")
        }
    }
}


extension URL {
    static let baseURL = "http://test.monocoding.com:35484/"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
}

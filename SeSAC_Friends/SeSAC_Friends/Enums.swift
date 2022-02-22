//
//  Enums.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/01.
//

import Foundation

enum GenderCase: Int {
    case man = 1
    case woman = 0
    case unselected = -1
    case all = 2
}

enum UserStatusCodeCase: Int {
    case success = 200
    case invalidNickname = 202
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum QueueStatusCodeCase: Int {
    case success = 200
    case blockedUser = 201
    case cancelPanlty1 = 203
    case cancelPanlty2 = 204
    case cancelPanlty3 = 205
    case invalidGender = 206
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum DeleteQueueStatusCodeCase: Int {
    case success = 200
    case matched = 201
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
    
}

enum OnQueueStatusCodeCase: Int {
    case success = 200
    case matced = 201
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum MyQueueStatusCodeCase: Int {
    case success = 200
    case matchingCanceled = 201
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum ReportOtherStatusCodeCase: Int {
    case success = 200
    case reported = 201
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum DodgeStatusCodeCase: Int {
    case success = 200
    case wrongOtherUid = 201
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum RateStatusCodeCase: Int {
    case success = 200
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
}

enum HobbyRequestStatusCodeCase: Int {
    case success = 200
    case alreadyRecievedRequest = 201 // 상대방이 이미 나에게 취미 함께하기 요청한 상태 -> hobbyaccept
    case otherCanceledMatcting = 202 // 상대방이 새싹친구 찾기를 중단한 상태
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
    
}

enum HobbyAcceptStatusCodeCase: Int {
    case success = 200
    case alreadyOtherMatched = 201 // 상대방이 이미 다른 사용자와 매칭된 상태
    case otherCanceledMatcting = 202 // 상대방이 새싹친구 찾기를 중단한 상태
    case alreadyIMatched = 203 // 내가 이미 다른 사람과 매칭된 상태
    // Toast 메시지 후 (GET, /queue/myQueueState) 호출
    
    case firebaseTokenError = 401
    case unAuthorized = 406
    case serverError = 500
    case clientError = 501
    
}

enum MyStatusCase: Int {
    case normal = 0
    case matching = 1
    case matched = 2
}

enum PopupVCCase: Int {
    
    case hobbyRequest = 1
    case hobbyAceept = 2
}

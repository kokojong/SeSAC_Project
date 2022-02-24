//
//  HomeViewModel.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/06.
//

import Foundation

class HomeViewModel {

    static let shared = HomeViewModel()
    
    var myUserInfo: Observable<MyUserInfo> = Observable(MyUserInfo(id: "", v: 0, uid: "", phoneNumber: "", email: "", fcMtoken: "",nick:"코코종", birth: "", gender: 0, hobby: "abc", comment: [], reputation: [], sesac: 0, sesacCollection: [], background: 0, backgroundCollection: [], purchaseToken: [],transactionID: [],reviewedBefore: [], reportedNum: 0, reportedUser: [], dodgepenalty: 0, dodgeNum: 0, ageMin: 0,ageMax: 0,searchable: 1, createdAt: ""))
    
    
    var onQueueResult: Observable<OnQueueResult> = Observable(OnQueueResult(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    
    var filteredQueueDB: Observable<[OnQueueResult.OtherUserInfo]> = Observable([])
    var filteredQueueDBRequested:
    Observable<[OnQueueResult.OtherUserInfo]> = Observable([])
    
    // MARK: lat + long -> region
    var centerLat = Observable(0.0)
    var centerLong = Observable(0.0)
    var centerRegion = Observable(0)
    
    var searchGender = Observable(2)
    
    var isLocationEnable = Observable(false)
    
    var myStatus: Observable<Int> = Observable(UserDefaults.standard.integer(forKey: UserDefaultKeys.myStatus.rawValue))
    
    var fromRecommendHobby: Observable<[String]> = Observable([])
    var fromNearFriendsHobby: Observable<[String]> = Observable([])
    var myFavoriteHobby: Observable<[String]> = Observable(["코딩", "이 아니라", "땐스", "음주가무"])
    
    var myQueueState = Observable(MyQueueStateResult(dodged: 0, matched: 0, reviewed: 0, matchedNick: "", matchedUid: ""))

    
    func searchNearFriends(form: OnQueueForm, completion: @escaping (OnQueueResult?, Int?, Error?) -> Void) {
        QueueAPIService.onQueue(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!, form: form) { onqueueResult, statuscode, error in
            
            guard let onqueueResult = onqueueResult else {
                return
            }
            
            self.onQueueResult.value = onqueueResult

            completion(onqueueResult, statuscode, error)
        }
        
    }
    
    func calculateRegion(lat: Double, long: Double) {
        
        centerLat.value = lat
        centerLong.value = long
        
        var strLat = String(lat+90)
        var strLong = String(long+180)
        
        strLat = strLat.components(separatedBy: ["."]).joined()
        strLong = strLong.components(separatedBy: ["."]).joined()
        
        let strRegion = strLat.substring(from: 0, to: 4) + strLong.substring(from: 0, to: 4)
        
        centerRegion.value = Int(strRegion) ?? 0
        
    }
    
    func getUserInfo(completion: @escaping (MyUserInfo?, Int?, Error?) -> Void) {
        UserAPIService.getMyUserInfo(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!) { userInfo, statuscode, error  in
         
            guard let userInfo = userInfo else {
                return
            }
            self.myUserInfo.value = userInfo
            
            UserDefaults.standard.set(userInfo.uid, forKey: UserDefaultKeys.myUid.rawValue)
            
            completion(userInfo,statuscode,error)
        }
        
    }
    
    func postQueue(form: PostQueueForm ,completion: @escaping (Int?, Error?) -> Void) {
        QueueAPIService.postQueue(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!, form: form) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }
            
            completion(statuscode, error)
        }
    }
    
    func deleteQueue(completion: @escaping (Int?, Error?) -> Void) {
        QueueAPIService.deleteQueue(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }
            
            completion(statuscode, error)
        }
        
    }
    
    func hobbyRequest(otheruid: String, completion: @escaping (Int?, Error?) -> Void) {
        QueueAPIService.hobbyRequest(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!, otheruid: otheruid) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }
            
            completion(statuscode, error)
        }
    }
    
    final func hobbyAccept(otheruid: String, completion: @escaping (Int?, Error?) -> Void) {
        QueueAPIService.hobbyAccept(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!, otheruid: otheruid) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }

            completion(statuscode, error)
        }
    }
    
    final func checkMyQueueStatus(completion: @escaping (MyQueueStateResult?, Int?, Error?) -> Void) {
        
        QueueAPIService.checkMyQueueStatus(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!) { myQueueState, statuscode, error in
            
            guard let myQueueState = myQueueState else {
                completion(nil, statuscode, error)
                return
            }
            
            self.myQueueState.value = myQueueState
            completion(myQueueState, statuscode, error)
        }
    }
    
    final func writeReview(form: WriteReviewFrom, completion: @escaping (Int?) -> Void) {
        QueueAPIService.writeReview(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!, form: form) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }

            completion(statuscode)
        }
    }
    
    final func dodgeMatching(otheruid: String, completion: @escaping (Int?) -> Void) {
        QueueAPIService.dodgeMatching(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!, otheruid: otheruid) { statuscode, error in
            
            guard let statuscode = statuscode else {
                return
            }

            completion(statuscode)
        }
    }
    
    final func reportOtherUser(form: ReportOtherFrom, completion: @escaping (Int) -> Void) {
        UserAPIService.reportOtherUser(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!, form: form) { statuscode in
            
            guard let statuscode = statuscode else {
                return
            }

            completion(statuscode)
            
        }
        
    }
    
}

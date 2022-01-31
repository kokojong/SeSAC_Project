//
//  ProfileViewModel.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/25.
//

import Foundation
import UIKit

class ProfileViewModel {
    
    var userInfo: Observable<MyUserInfo> = Observable(MyUserInfo(id: "", v: 0, uid: "", phoneNumber: "", email: "", fcMtoken: "",nick:"코코종", birth: "", gender: 0, hobby: "", comment: [], reputation: [], sesac: 0, sesacCollection: [], background: 0, backgroundCollection: [], purchaseToken: [],transactionID: [],reviewedBefore: [], reportedNum: 0, reportedUser: [], dodgepenalty: 0, dodgeNum: 0, ageMin: 0,ageMax: 0,searchable: 0, createdAt: ""))
    
//    var userInfo : Observable<MyUserInfo>!
    
    
    var iconIamgeArray = [UIImage(named: "notice"), UIImage(named: "faq"), UIImage(named: "qna"), UIImage(named: "setting_alarm"), UIImage(named: "permit")]
    
    var titleArray = ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "이용 약관"]
    
    
    func updateAgeRange(minValue: Int, maxValue: Int) {
        self.userInfo.value.ageMin = minValue
        self.userInfo.value.ageMax = maxValue
    }
    
    func getUserInfo(completion: @escaping (MyUserInfo?, Int?, Error?) -> Void) {
        APISevice.getMyUserInfo(idToken: UserDefaults.standard.string(forKey: "idToken")!) { userInfo, statuscode, error  in
         
            guard let userInfo = userInfo else {
                return
            }
            self.userInfo.value = userInfo
            
            completion(userInfo,statuscode,error)
        }
        
    }
    
    
}



extension ProfileViewModel {
    var numberOfRowsInSection: Int {
        return iconIamgeArray.count+1
    }
    
    func cellForRowAt(indexPath: IndexPath) -> (UIImage?,String?) {
        return (iconIamgeArray[indexPath.row-1],titleArray[indexPath.row-1])
    }
}

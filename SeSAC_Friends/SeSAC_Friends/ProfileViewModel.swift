//
//  ProfileViewModel.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/25.
//

import Foundation

class ProfileViewModel {
    
//    static var shared = ProfileViewModel()
    
    var userInfo: Observable<MyUserInfo> = Observable(MyUserInfo(id: "", v: 0, uid: "", phoneNumber: "", email: "", fcMtoken: "",nick:"코코종", birth: "", gender: 0, hobby: "abc", comment: [], reputation: [], sesac: 0, sesacCollection: [], background: 0, backgroundCollection: [], purchaseToken: [],transactionID: [],reviewedBefore: [], reportedNum: 0, reportedUser: [], dodgepenalty: 0, dodgeNum: 0, ageMin: 0,ageMax: 0,searchable: 1, createdAt: ""))
    
    var ageMin = Observable(0)
    var ageMax = Observable(0)
    var searchable = Observable(1)
    var gender = Observable(0)
    var hobby = Observable("")
    
    var iconIamgeArray = ["notice", "faq", "qna", "setting_alarm", "permit"]
    
    var titleArray = ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "이용 약관"]
    
    
    func updateMypage(form: UpdateMypageForm) {
        UserAPISevice.updateMypage(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!, form: form) { statuscode in
            
        }
    }
    
    func getUserInfo(completion: @escaping (MyUserInfo?, Int?, Error?) -> Void) {
        UserAPISevice.getMyUserInfo(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!) { userInfo, statuscode, error  in
         
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
    
    func cellForRowAt(indexPath: IndexPath) -> (String, String) {
        return (iconIamgeArray[indexPath.row-1],titleArray[indexPath.row-1])
    }
}

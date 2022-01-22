//
//  AuthViewModel.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/20.
//

import Foundation
import FirebaseAuth

//"phonNumber": "+821012345678",
//  "FCMtoken": "evjaeofaweflkalrgiamerglarmfkalwemrawlekrmalkwermklawerew",
//  "nick": "고래밥",
//  "birth": "2022-01-16T09:23:44.054Z",
//  "email": "user@example.com",
//  "gender": 1

class AuthViewModel {
    
    var phoneNumber = Observable("")
    var onlyNumber = Observable("")
    
    var verificationID = ""
    var verificationCode = ""
    
    var nickname = Observable("")
    var birthday = Observable("2021-01-30T08:30:20.000Z")
    var email = Observable("")
    var gender = Observable(2)
    
    var isValidPhoneNumber = Observable(false)
    var isValidNickname = Observable(false)
    var isValidEmail = Observable(false)
    
    var idToken = ""
    
    var fcmToken = UserDefaults.standard.string(forKey: "FCMToken")
    
    func addHyphen() {
        phoneNumber.value = phoneNumber.value.pretty()
    }
    
    func checkValidPhoneNumber(phone: String?) -> Void {
        guard phone != nil else { return }
        
        let phoneRegEx = "^010-?([0-9]{4})-?([0-9]{4})"
        let pred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        isValidPhoneNumber.value = pred.evaluate(with: phone)
    }
    
    func checkValidCode(code: String?) -> Bool {
        guard code != nil else { return false }
        
        let codeRegEx = "([0-9]{6})"
        let pred = NSPredicate(format:"SELF MATCHES %@", codeRegEx)
        return pred.evaluate(with: code)
    }
    
    func checkValidNickname(nickname: String) -> Void {
        if nickname.count > 0 && nickname.count <= 10 {
            isValidNickname.value = true
        } else {
            isValidNickname.value = false
        }
        
    }
    
    func checkValidEmail(email: String) -> Void {
        if email.contains("@") && email.contains(".") {
            isValidEmail.value = true
        } else {
            isValidEmail.value = false
        }
        
    }
    
    
    func requestCode(completion: @escaping (String?,Error?) -> Void) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber("+82\(onlyNumber.value)", uiDelegate: nil) { verificationID, error in
               
                guard let error = error else {
                    completion(verificationID, nil)
                    return
                }
                
                completion(nil, error)
            }
    }
    
    func checkCode(completion: @escaping (AuthDataResult? ,Error?) -> Void) {
        
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: verificationCode

        )
       
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error == nil {
                print("로그인 성공!")

                let currentUser = Auth.auth().currentUser
                currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                    
                    if let error = error {
                        // Handle error
                        completion(authResult ,error)
                        return;
                    }
                    if let idToken = idToken {
                        print("idToken",idToken)
                        self.idToken = idToken
                    }
                    completion(authResult, nil)
                    
                }
                
            } else {
                completion(nil, error)
                print("error : ",error.debugDescription)
                
            }
            
        }
        
    }
    
    func getUserInfo (completion: @escaping (Int? ,Error?) -> Void) {
        APISevice.getMyUserInfo(idToken: idToken) { userInfo,  statuscode, error  in
            print("getUserInfo")
            print(error)
            print(userInfo)
            completion(statuscode,error)
        }
        
    }
    
    
}

//
//  AuthViewModel.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/20.
//

import Foundation
import FirebaseAuth

class AuthViewModel {
    
    var phoneNumber = Observable("")
    var onlyNumber = Observable("")
    
    var verificationID = ""
    var verificationCode = ""
    
    var nickname = Observable("")
    var birthday = Observable(Date.now)
    var email = Observable("")
    var gender = Observable(2)
    
    var isValidPhoneNumber = Observable(false)
    var isValidNickname = Observable(false)
    var isValidEmail = Observable(false)
    
    var idToken = ""
    
    var fcmToken = UserDefaults.standard.string(forKey: UserDefaultKeys.FCMToken.rawValue)!
    
    func addHyphen() {
        phoneNumber.value = phoneNumber.value.pretty()
    }
    
    func checkValidPhoneNumber(phone: String?) -> Void {
        guard phone != nil else { return }
        
        let phoneRegEx = "^01[0-1]-?([0-9]{3,4})-?([0-9]{4})"
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
    
    func getBirthdayElements(bitrhday: Date) -> [String] {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm"

        let selectedDate: String = dateFormatter.string(from: bitrhday)
        
        let year = selectedDate.substring(from: 0, to: 3)
        let month = selectedDate.substring(from: 5, to: 6)
        let day = selectedDate.substring(from: 8, to: 9)
        
        return [year,month,day]
    }
    
    
    func checkValidEmail(email: String) -> Void {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let pred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        isValidEmail.value = pred.evaluate(with: email)
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
                        UserDefaults.standard.set(idToken, forKey: UserDefaultKeys.idToken.rawValue)
                    }
                    completion(authResult, nil)
                    
                }
                
            } else {
                completion(nil, error)
                print("error : ",error.debugDescription)
                
            }
            
        }
        
    }
    
    func getUserInfo(completion: @escaping (MyUserInfo?, Int?, Error?) -> Void) {
        APISevice.getMyUserInfo(idToken: idToken) { userInfo, statuscode, error  in
         
            completion(userInfo,statuscode,error)
        }
        
    }
    
    
    func signUpUserInfo(completion: @escaping (Int?, Error?) -> Void) {
        
        let form = SignUpForm(phoneNumber: "+82" + onlyNumber.value, FCMtoken: fcmToken, nick: nickname.value, email: email.value, birth: birthday.value, gender: gender.value)
        
        print("form",form)
        print(Date.now)
        
        APISevice.signUpUserInfo(idToken: idToken, form: form) { statuscode, error in
       
            completion(statuscode, error)
            
        }
    }
    
}



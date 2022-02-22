//
//  UserAPIService.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/20.
//

import Foundation
import Alamofire


class UserAPIService {
    
    static func getMyUserInfo(idToken: String, completion: @escaping (MyUserInfo? , Int?, Error?) -> Void) {
        let headers = ["idtoken": idToken] as HTTPHeaders

        AF.request(UserEndPoint.getMyUserInfo.url.absoluteString, method: .get, headers: headers).responseDecodable(of: MyUserInfo.self) {  response in
 
            let statusCode = response.response?.statusCode
            //
            switch response.result {
            case.success(let value):
                completion(response.value, statusCode, nil)
                         
            case .failure(let error):
                completion(nil, statusCode, error)
              
            }
        }
        .responseString { response in
            print("responseString", response)
        }
        
    }
    
    static func signUpUserInfo(idToken: String, form: SignUpForm, completion: @escaping (Int?, Error?) -> Void){
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
       
        let parameters : Parameters = [
            "phoneNumber" : form.phoneNumber,
            "FCMtoken" : form.FCMtoken,
            "nick" : form.nick,
            "birth" : form.birth,
            "email" : form.email,
            "gender" : form.gender
        ]
        
        AF.request(UserEndPoint.postMyUserInfo.url.absoluteString, method: .post, parameters: parameters, headers: headers)
            .responseString { response in
                print("responseString", response.response)
                completion(response.response?.statusCode, nil)
            }
    }
    
    static func withdrawSignUp(idToken: String, completion: @escaping (Int?, Error?) -> Void){
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
    
        AF.request(UserEndPoint.withdrawSignUp.url.absoluteString, method: .post, headers: headers).responseString { response in
            
            completion(response.response?.statusCode, nil)
        }
    }
    
    static func updateMypage(idToken: String, form: UpdateMypageForm, completion: @escaping (Int?) -> Void) {
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
        
        let parameters : Parameters = [
            "searchable" : form.searchable,
            "ageMin" : form.ageMin,
            "ageMax" : form.ageMax,
            "gender" : form.gender,
            "hobby" : form.hobby
        ]
        
        print("real token", idToken)
        AF.request(UserEndPoint.updateMypage.url.absoluteString, method: .post, parameters: parameters, headers: headers).responseString { response in
            completion(response.response?.statusCode)
        }
        
    }
    
    static func updateFCMToken(idToken: String, fcmToken: String, completion: @escaping (Int?) -> Void) {
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
        
        let parameters : Parameters = [
            "FCMtoken" : fcmToken
        ]
        
        AF.request(UserEndPoint.updateFCMToken.url.absoluteString, method: .put, parameters: parameters, headers: headers).responseString { response in
            
            completion(response.response?.statusCode)
            
        }
        
    }
    
    static func reportOtherUser(idToken: String, form: ReportOtherFrom, completion: @escaping (Int?) -> Void) {
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
        
        let parameters : Parameters = [
            "otheruid" : form.otheruid,
            "reportedReputation" : form.reportedReputation,
            "comment" : form.comment
        ]
            
        AF.request(UserEndPoint.reportOtherUser.url.absoluteString, method: .post, parameters: parameters, encoding: URLEncoding(arrayEncoding: .noBrackets), headers: headers).responseString { response in
            
            completion(response.response?.statusCode)
        }
        
    }
    
    
}

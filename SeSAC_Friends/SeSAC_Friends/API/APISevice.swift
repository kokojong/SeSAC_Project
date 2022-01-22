//
//  APISevice.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/20.
//

import Foundation
import Alamofire
import SwiftyJSON

class APISevice {
    
    static func getMyUserInfo(idToken: String, completion: @escaping (MyUserInfo? , Int?, Error?) -> Void) {
        let headers = ["idtoken": idToken] as HTTPHeaders

        AF.request(EndPoint.getMyUserInfo.url.absoluteString, method: .get, headers: headers).responseDecodable(of: MyUserInfo.self) {  response in
         
            
            let statusCode = response.response?.statusCode
            //
            switch response.result {
            case.success(let value):
                print("response.result success", value)
                completion(response.value, statusCode, nil)
                         
            case .failure(let error):
                print("response.result error",error)
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
            "genger" : form.gender
            
        ]
        
        AF.request(EndPoint.postMyUserInfo.url.absoluteString, method: .post, parameters: parameters, headers: headers)
        //            .responseDecodable(of: MyUserInfo.self) { response in
        //
        //            let statusCode = response.response?.statusCode
        //            //
        //            switch response.result {
        //            case.success(let value):
        //                print("response.result success", value)
        //                completion(statusCode, nil)
        //
        //            case .failure(let error):
        //                print("response.result error",error)
        //                completion(statusCode, error)
        //
        //            }
        //        }
            .responseString { response in
                print("responseString", response)
                completion(response.response?.statusCode, nil)
                
            }
        
        
    }
    
    
}

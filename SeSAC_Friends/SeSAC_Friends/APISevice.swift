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
        
//        AF.request(EndPoint.getMyUserInfo.url.absoluteString, method: .get, headers: headers).validate().responseJSON { response in
//            switch response.result{
//            case .success(let value):
//                let json = JSON(value)
//
//                print("json", json)
//
//
//            case .failure(let error):
//                print(error)
//                completion(error)
//            }
//        }
        
        AF.request(EndPoint.getMyUserInfo.url.absoluteString, method: .get, headers: headers).responseDecodable(of: MyUserInfo.self) {  response in
         
            
            let statusCode = response.response?.statusCode
            //
            switch response.result {
            case.success(let value):
                print("response.result success", value)
                completion(nil, statusCode, nil)
                
                
            case .failure(let error):
                print("response.result error",error)
                completion(nil, statusCode, error)
                
        
            }
        }
        .responseString { response in
            print("responseString", response)
        }
        
        
        
        
       
        
    }
    
    
}

//
//  QueueAPIService.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/06.
//

import Foundation
import Alamofire

class QueueAPIService {
 
    static func onQueue(idToken: String, form: OnQueueForm, completion: @escaping (OnQueueResult? , Int?, Error?) -> Void) {
        
        let headers = ["idtoken": idToken] as HTTPHeaders
        
        let parameters: Parameters = [
            "region": form.region,
            "lat": form.lat,
            "long": form.long
        ]
        
        AF.request(QueueEndPoint.onQueue.url.absoluteString, method: .post, parameters: parameters, headers: headers).responseDecodable(of: OnQueueResult.self) { response in
            
            print(response)
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let value):
                completion(response.value, statusCode, nil)
            case .failure(let error):
                completion(nil, statusCode, error)
            }
            
        }
        
    }
    
    static func postQueue(idToken: String, form: PostQueueForm, completion: @escaping (Int?, Error?) -> Void) {
        
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
        
        let parameters: Parameters = [
            "type": form.type,
            "region": form.region,
            "long": form.long,
            "lat": form.lat,
            "hf": form.hf
        ]
        
        AF.request(QueueEndPoint.postQueue.url.absoluteString, method: .post, parameters: parameters, encoding: URLEncoding(arrayEncoding: .noBrackets), headers: headers)
            .responseString { response in
                
                completion(response.response?.statusCode, response.error)
            }
    }
    
    static func deleteQueue(idToken: String, completion: @escaping (Int?, Error?) -> Void) {
        
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
        
        AF.request(QueueEndPoint.postQueue.url.absoluteString, method: .delete, headers: headers)
            .responseString { response in
                
                completion(response.response?.statusCode, response.error)
            }
    }
    
    static func hobbyRequest(idToken: String, otheruid: String, completion: @escaping (Int?, Error?) -> Void) {
        
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
        
        let parameters: Parameters = [
            "otheruid": otheruid
        ]
        
        AF.request(QueueEndPoint.hobbyRequest.url.absoluteString, method: .post, parameters: parameters, headers: headers)
            .responseString { response in
                
                completion(response.response?.statusCode, response.error)
            }
        
    }
    
    static func hobbyAccept(idToken: String, otheruid: String, completion: @escaping (Int?, Error?) -> Void) {
        
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
        
        let parameters: Parameters = [
            "otheruid": otheruid
        ]
        
        AF.request(QueueEndPoint.hobbyAccept.url.absoluteString, method: .post, parameters: parameters, headers: headers)
            .responseString { response in
                
                completion(response.response?.statusCode, response.error)
            }
    }
    
    static func checkMyQueueStatus(idToken: String, completion: @escaping (MyQueueStateResult?, Int?, Error?) -> Void) {
        
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
        
        
        AF.request(QueueEndPoint.myQueueState.url.absoluteString, method: .get, headers: headers)
            .responseDecodable(of: MyQueueStateResult.self) { response in
                
                let statusCode = response.response?.statusCode
                
                switch response.result {
                case .success(let value):
                    completion(response.value, statusCode, nil)
                case .failure(let error):
                    completion(nil, statusCode, error)
                }
                
            }
    }
    
    static func writeReview(idToken: String, form: WriteReviewFrom, completion: @escaping (Int?, Error?) -> Void) {
        
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
        
        let parameters: Parameters = [
            "otheruid": form.otheruid,
            "reputation": form.reputation,
            "comment": form.comment
        ]
        
        AF.request(QueueEndPoint.writeReview(id: form.otheruid).url.absoluteString, method: .post, parameters: parameters, headers: headers)
            .responseString { response in
                
                completion(response.response?.statusCode, response.error)
            }
    }
    
    static func dodgeMatching(idToken: String, otheruid: String, completion: @escaping (Int?, Error?) -> Void) {
        
        let headers = ["idtoken": idToken,
                       "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
        
        let parameters: Parameters = [
            "otheruid": otheruid
        ]
        
        AF.request(QueueEndPoint.dodge.url.absoluteString, method: .post, parameters: parameters, headers: headers)
            .responseString { response in
                
                completion(response.response?.statusCode, response.error)
            }
    }
    
    
}

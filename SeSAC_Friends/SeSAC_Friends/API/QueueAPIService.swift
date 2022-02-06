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
    
}

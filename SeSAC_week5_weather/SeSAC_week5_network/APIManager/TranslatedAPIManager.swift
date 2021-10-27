//
//  TranslatedAPIManager.swift
//  SeSAC_week5_network
//
//  Created by kokojong on 2021/10/27.
//

import Foundation
import SwiftyJSON
import Alamofire

class TranslatedAPIManager {
    
    static let shared = TranslatedAPIManager()
    
    typealias CompleteHandler = (Int, JSON) -> ()
    
    
    func fetchTranslatedData(text: String, result: @escaping CompleteHandler ) {
        
        let url = EndPoint.papagoURL
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.NAVER_ID,
            "X-Naver-Client-Secret": APIKey.NAVER_SECRET
        ]
        let parameters = [
            "source": "ko",
            "target": "en",
            "text": text
        ]
        
        // 1. 상태 코드 validate(statusCode: 200...500)
        // 2. 상태 코드 분기
        AF.request(url, method: .post, parameters: parameters, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let code = response.response?.statusCode ?? 500
                
                result(code,json)
                
        
                
//                self.targetTextView.text = json["message"]["result"]["translatedText"].stringValue
            case .failure(let error): // 네트워크 통신이 안될 때
                print(error)
            }
        }
    }
}

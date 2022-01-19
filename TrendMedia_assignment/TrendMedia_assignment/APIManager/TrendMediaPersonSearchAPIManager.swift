//
//  TrendMediaPersonSearchAPIManager.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/31.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit

class TrendMediaPersonSearchAPIManager {
    
    static let shared = TrendMediaPersonSearchAPIManager()
    
    typealias CompleteHandler = (JSON) -> ()
    
    func fetchTrendMediaPersonSearchData(person_id: Int, result: @escaping CompleteHandler ) {
        
        let url = EndPoint.TMDB_PERSON_SEARCH_URL + "\(person_id)" + "/movie_credits?" + "api_key=\(API_KEY.TMDB_ID)" + "&language=en-US"
        
        // UIImage를 바이너리 타입으로 변환
        
        AF.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json =  JSON(value)
                result(json)
            
            case .failure(let error):
                print("error: \(error)")
            
            }
        }
        
    }
    
}

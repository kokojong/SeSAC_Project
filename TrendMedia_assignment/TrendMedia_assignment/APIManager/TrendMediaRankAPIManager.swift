//
//  TrendMediaAPIManager.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/27.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit

class TrendMediaRankAPIManager {
    
    static let shared = TrendMediaRankAPIManager()
    
    typealias CompleteHandler = (JSON) -> ()
    
    
    func fetchTrendMediaData(page: Int, result: @escaping CompleteHandler ) {
        
        let url = EndPoint.TMDB_URL + "api_key=\(API_KEY.TMDB_ID)" + "&query=&page=\(page)"
        
        // UIImage를 바이너리 타입으로 변환
        
        AF.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json =  JSON(value)
                print("JSON: \(json)")
                result(json)
            
            case .failure(let error):
                print("error: \(error)")
            
            }
        }
        
    }
    
}

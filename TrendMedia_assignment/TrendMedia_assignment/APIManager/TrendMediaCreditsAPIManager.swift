//
//  TrendMediaCreditsAPIManager.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/28.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit

class TrendMediaCreditsAPIManager {
    
    static let shared = TrendMediaCreditsAPIManager()
    
    typealias CompleteHandler = (JSON) -> ()
    
    
    func fetchTrendMediaCreditsData(movie_id: Int, result: @escaping CompleteHandler ) {
        
        let url = EndPoint.TMDB_CREDITS_URL + "\(movie_id)" + "/credits?" + "api_key=\(API_KEY.TMDB_ID)" + "&language=en-US"
//    https://api.themoviedb.org/3/tv/{tv_id}/credits?api_key=5d30a263c2ce99f0a519e8a598c4d176&language=en-US
        
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

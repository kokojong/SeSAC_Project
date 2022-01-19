//
//  WeatherAPIManager.swift
//  SeSAC_week5_network
//
//  Created by kokojong on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherAPIManager {
    static let shared = WeatherAPIManager()
    
    typealias CompleteHandler = (JSON) -> ()
    
    func fetchWeatherData(lat: Double, lon: Double, result: @escaping CompleteHandler ) {
        
        let url = "\(EndPoint.openWeatherURL)lat=\(lat)&lon=\(lon)&appid=\(APIKey.OPEN_WEATHER)"
        
        AF.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")                
                result(json)

            case .failure(let error): // 네트워크 통신이 안될 때
                print(error)
            }
        }
    }
}

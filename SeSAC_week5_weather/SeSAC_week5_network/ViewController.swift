//
//  ViewController.swift
//  SeSAC_week5_network
//
//  Created by kokojong on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentWeather()
    }
    
    func getCurrentWeather() {
            
            let url = "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=cbb08215c4818146e8ec274c270bdce9"
            
            AF.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }

        
    }


}


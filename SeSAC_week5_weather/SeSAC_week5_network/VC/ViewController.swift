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

    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
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
                    
                    let currentTemp = json["main"]["temp"].doubleValue - 273.15
                    print(currentTemp)
                    self.currentTempLabel.text = String(format: "%.2f", currentTemp)
                    
                    let windSpeed = json["wind"]["speed"].doubleValue
                    self.windSpeedLabel.text = String(format: "%.2f", windSpeed)
                    
                    let humidity = json["main"]["humidity"].intValue
                    self.humidityLabel.text = String(format: "%d", humidity)
                
                    let icon = json["weather"]["icon"].stringValue
//                    self.iconImageView.image =
                    // http://openweathermap.org/img/wn/10d@2x.png
                    
                    
                case .failure(let error):
                    print(error)
            }
        }

        
    }


}


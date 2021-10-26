//
//  WeatherViewController.swift
//  SeSAC_week5_network
//
//  Created by kokojong on 2021/10/25.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire
import Kingfisher

class WeatherViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    let locationManager = CLLocationManager()
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        
        loadOpenWeatherData()
        
        
        
    }
    
    @IBAction func onRefreshButtonClicked(_ sender: UIButton) {
    
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus // location 매니저의 상태를 가져옴
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus() //
        }
        
        if CLLocationManager.locationServicesEnabled() {
            // 9번인 checkCurrentLocationAuthorization를 실행 (권한 상태 확인 및 권한 요청 가능)
            checkCurrentLocationAuthorization(authorizationStatus: authorizationStatus)
        } else {
            print("위치 서비스가 꺼져있음")
        }
    
    }
    
    
    
    func loadOpenWeatherData() {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=cbb08215c4818146e8ec274c270bdce9"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let temp = json["main"]["temp"].doubleValue - 273.15
                let humidity = json["main"]["humidity"].doubleValue
                let windSpeed = json["wind"]["speed"].doubleValue
               
                self.temperatureLabel.text = String(format: " 현재 온도는 %.2f도 입니다", temp)
                self.humidityLabel.text = String(format: "현재 습도는 %.2f 입니다", humidity)
                self.windSpeedLabel.text = String(format: "현재 풍속은 %.2f 입니다", windSpeed)
                
                
                let icon = json["weather"][0]["icon"].stringValue
                let url = URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png")
                self.weatherImageView.kf.setImage(with: url)
                print(url!)
                
                
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    // 성공
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate{ // 여기서는 미국이 나오니까 일단은 건대에 고정으로 하기
            // 37.540559136949575, 127.06919016707388
            
            self.latitude = coordinate.latitude
            self.longitude = coordinate.longitude
            // 10 위치업데이트 멈춰!
            locationManager.stopUpdatingLocation()
            
            // 00구 00동 으로 표기하기
            showTitle(coordi: coordinate)
            
        } else {
            print("Location Cannot Find")
        }
    }
    
    func showTitle(coordi: CLLocationCoordinate2D) {
        let geocoder = CLGeocoder()
        let findLocation = CLLocation(latitude: coordi.latitude, longitude: coordi.longitude)
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address : [CLPlacemark] = placemarks {
                let gu = address[0].locality
                let dong = address[0].thoroughfare
            
                self.locationLabel.text = "\(gu!) \(dong!)"
            }
            
        })
        
    }
    // 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("didFailWithError")
    }
    
    
    
    // 6. 14미만 권한이 바뀔때
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
    
    // 7. 14이상 권한이 바뀔때
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServiceAuthoriztaion() // 사용자 정의 함수
    }
    
    // 8? iOS 버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
    func checkUserLocationServiceAuthoriztaion() {
        
        let authorizationStatus: CLAuthorizationStatus // 권한의 상태?
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus // location 매니저의 상태를 가져옴
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus() //
        }
        
        // iOS 위치 서비스를 확인
        if CLLocationManager.locationServicesEnabled() {
            // 9번인 checkCurrentLocationAuthorization를 실행 (권한 상태 확인 및 권한 요청 가능)
            checkCurrentLocationAuthorization(authorizationStatus: authorizationStatus)
        } else {
            print("위치 서비스가 꺼져있음")
        }
        
    }
    
    // 9? 사용자의 위치 권한 상태 확인(UDF 사용자 정의 함수로 프로토콜 내의 메서드가 아님! user defineded func?)
    // 사용자가 위치를 허용했는지 안햇는지 거부했는지 같은 권한을 확인 (단, iOS위치 서비스가 가능한지 확인)
    // @unknown
    func checkCurrentLocationAuthorization(authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined: // 권한이 아예 설정 안되어있을 때
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권한 요청
            locationManager.startUpdatingLocation() // 위치 접근 시작! -> didUpdateLocations 실행
            
        case .restricted, .denied:
            print("DENIED, 설정으로 유도")
            showAlert(title: "위치 권한", message: "위치 권한을 설정해주세요", okTitle: "설정하기") {
                self.goToSetting()
            }
            
                        
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() // 위치 접근 시작! -> didUpdateLocations 실행
        case .authorizedAlways:
            print("always")
        @unknown default:
            print("default")
        }
        
        
        
        if #available(iOS 14.0, *){
            // 정확도 체크 : 정확도 감소가 되어있을 경우, 1시간에 4번으로 제한, 미리 알림등이 제한, 배터리는 오래쓸수있음,
            let accurancyState = locationManager.accuracyAuthorization
            switch accurancyState {
            case .fullAccuracy:
                print("Full")
            case .reducedAccuracy:
                print("reduce")
            @unknown default:
                print("default")
            
            }
        }
    }
    
    func goToSetting() {
        
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url) { success in
                print("잘 열렸다 \(success)")
            }
        }

    }
    
    func showAlert(title: String, message: String, okTitle: String, okAction: @escaping () -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        
        let ok = UIAlertAction(title: okTitle, style: .default) { _ in
            okAction()
        }

        
        alert.addAction(cancle)
        alert.addAction(ok)
        
        present(alert, animated: true) {
            print("alert 띄움")
        }
    }
    
}

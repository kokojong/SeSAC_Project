//
//  LocationViewController.swift
//  SeSAC_week4
//
//  Created by kokojong on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI // iOS15 LocationButton 등장

/* 나중에 할 것
 1. 설정 유도
 2. 위경도 -> 주소로 변환
 
 */

class LocationViewController: UIViewController {
    
    @IBOutlet weak var userCurrentLocation: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // 1.
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userCurrentLocation.backgroundColor = .red
        
        UIView.animate(withDuration: 5) {
            self.userCurrentLocation.alpha = 0.1
        }
        
        

        // 37.540576151212015, 127.06923308241498
        // 지역을 설정
        let location = CLLocationCoordinate2D(latitude: 37.540576151212015, longitude: 127.06923308241498)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)

        // 핀
        let annotation = MKPointAnnotation()
        annotation.title = "HERE!"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
//        mapView.removeAnnotation() 삭제
        
        // 맵뷰에 어노테이션을 삭제하고자 할 때
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations) // 여러개 삭제
        
        mapView.delegate = self
        
        // 2.
        locationManager.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func alertButtonClicked(_ sender: UIButton) {
        showAlert(title: "설정", message: "권한 허용해죠", okTitle: "설정으로 이동") {
            
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url) { success in
                    print("잘 열렸다 \(success)")
                }
            }
        }
    }
    
    @IBAction func updateLabelButtonClicked(_ sender: UIButton) {
        showAlert(title: "텍스트 변경", message: "레이블의 글자를 바꿀게요", okTitle: "꾸랭") {
            self.userCurrentLocation.text = "asldkfasdf"
        }
    }
}

// 3.
extension LocationViewController : CLLocationManagerDelegate {
    
    // 9. iOS 버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
    func checkUserLocationServiceAuthoriztaion() {
        
        let authorizationStatus : CLAuthorizationStatus
        
        if #available(iOS 14.0, *){
            authorizationStatus = locationManager.authorizationStatus // iOS 14이상에서만 사용이 가능
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()  // 14미만
        }
        
        // iOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            // 권한 상태 확인 및 권한 요청 가능(8번 메서드 실행)
            checkCurrentLocationAuthorization(authorizationStatus)
            
        } else {
            print("ios 위치 서비스를 켜주세요")
        }
        
    }
    
    
    // 8. 사용자의 위치 권한 상태 확인(UDF 사용자 정의 함수로 프로토콜 내의 메서드가 아님! user defineded func?)
    // 사용자가 위치를 허용했는지 안햇는지 거부했는지 같은 권한을 확인 (단, iOS위치 서비스가 가능한지 확인)
    // @unknown
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined: // 권한이 아예 설정 안되어있을 때
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권한 요청
            locationManager.startUpdatingLocation() // 위치 접근 시작! -> didUpdateLocations 실행
        
        case .restricted, .denied:
            print("DENIED, 설정으로 유도")
            
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() // 위치 접근 시작! -> didUpdateLocations 실행
            
        case .authorizedAlways:
            print("always")
        @unknown default:
            print("default")
        }
        
        // 찾아보기!
        if #available(iOS 14.0, *){
            
            // 정확도 체크 : 정확도 감소가 되어있을 경우, 1시간에 4번으로 제한, 미리 알림등이 제한, 배터리는 오래쓸수있음, 워치 7부터
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
    
    
    
    // 4. 사용자가 위치 허용을 한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations)
        
        // 점점 정확하게 찾아가는거라서 나중에 온게 정확(이게 내위치)
        if let coordinate = locations.last?.coordinate{
            
            let annotation = MKPointAnnotation()
            annotation.title = "CURRNET LOCATION"
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            // 10.(중요) 비슷한 위치라면? 업데이트를 중지해라
            locationManager.stopUpdatingLocation()
//            locationManager.startUpdatingLocation()
            
            
        } else {
            print("Location Cannot Find")
        }
    }
    
    // 5. 위치 접근이 실패했을 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    // 6. iOS 14미만 : 앱이 위치관리자를 생성하고, 승인 상태가 변경이 될때 대리자에게 승인 상태를 알려줌
    // 권한이 변경될때마다 감지해서 실행이 됨
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
    
    // 7. iOS 14이상 : 앱이 위치관리자를 생성하고, 승인 상태가 변경이 될때 대리자에게 승인 상태를 알려줌
    // 권한이 변경될때마다 감지해서 실행이 됨
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServiceAuthoriztaion()
    }
    
}

extension LocationViewController: MKMapViewDelegate {
    // 맵 어노테이션 클릿기 이벤트 핸들링
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Hi")
    }
}

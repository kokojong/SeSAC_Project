//
//  TheaterViewController.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation

class TheaterViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    // 1. location manager 선언
    let locationManager = CLLocationManager()
    
    var theaterList = TheaterList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2. delegate 처리
//        mapView.delegate = self
        locationManager.delegate = self
        
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonClicked))
        
        self.navigationItem.rightBarButtonItem = filterButton
        
       showAllAnnotation()
        
        
        
    }
    
    @objc func filterButtonClicked() {
        // UIAlertController 초기화

        let actionsheetController = UIAlertController(title: "영화관을 선택해주세요", message: "보여질 영화관을 선택해주세요", preferredStyle: .actionSheet)

        // UIAlertAction 설정
        // handler : 액션 발생시 호출
        let actionLotteCinema = UIAlertAction(title: "롯데 시네마", style: .default) { action in
            self.filterAnnotation(keyword: "롯데시네마")
        }

        let actionMegaBox = UIAlertAction(title: "메가박스", style: .default) { action in
            self.filterAnnotation(keyword: "메가박스")
        }
        
        let actionCGV = UIAlertAction(title: "CGV", style: .default) { action in
            self.filterAnnotation(keyword: "CGV")
        }

        let actionShowAll = UIAlertAction(title: "전체보기", style: .default) { action in
            self.showAllAnnotation()
        }


        // **cancel 액션은 한개만 됩니닷 !!
        let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        actionsheetController.addAction(actionLotteCinema)
        actionsheetController.addAction(actionMegaBox)
        actionsheetController.addAction(actionCGV)
        actionsheetController.addAction(actionShowAll)
        actionsheetController.addAction(actionCancel)
        
        self.present(actionsheetController, animated: true, completion: nil)
        
    }
    
    // 필터기능 메서드로 만들기
    func filterAnnotation(keyword : String) {
        for theater in theaterList.mapAnnotations {
            let location = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.subtitle = theater.type
            
            mapView.addAnnotation(annotation)
            
            let removes = mapView.annotations.filter { anno in
                if anno.subtitle == keyword { return false } // 키워드와 동일하면 제거x
                else {
                    return true
                }
            }
            
//            mapView.addAnnotation(annotation) 이렇게 순서를 바꿔서 쓰면 오류가 난다(마지막 요소가 계속 남음)
            mapView.removeAnnotations(removes)
        
        }
    }
    
    func showAllAnnotation() {
        for theater in theaterList.mapAnnotations {
            let location = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.subtitle = theater.type
            
            mapView.addAnnotation(annotation)
        
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
        
        self.present(alert, animated: true) {
            print("alert 띄움")
        }
    }
    

}




// 3. extension
extension TheaterViewController: CLLocationManagerDelegate {
    
    // 4. 허용해서 업데이트가 된 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 제일 마지막으로 업데이트된 위치의 좌표 -> 내 위치
        if let coordinate = locations.last?.coordinate{ // 여기서는 미국이 나오니까 일단은 건대에 고정으로 하기
            // 37.540559136949575, 127.06919016707388
                
            // 핀 정의
            let annotation = MKPointAnnotation()
            annotation.title = "내 위치!!"
            annotation.coordinate = coordinate // 좌표를 넣음
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) // 확대?범위
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            // 10 위치업데이트 멈춰!
            locationManager.stopUpdatingLocation()
//            locationManager.startUpdatingLocation()
            
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
            
                self.title = "\(gu!) \(dong!)"
            }
            
        })
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
    
    
    // 5. 위치 접근에 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        37.566442275899, 126.97798742412988 (서울특별시청)
        let coordinate = CLLocationCoordinate2D(latitude: 37.566442275899, longitude: 126.97798742412988)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        let annotation = MKPointAnnotation()
        annotation.title = "서울시청!!"
        annotation.coordinate = coordinate // 좌표를 넣음
        mapView.addAnnotation(annotation)
        
        mapView.setRegion(region, animated: true)
        
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
            showAlert(title: "위치 권한", message: "위치 권한이 없으면 서울시청으로 간닷", okTitle: "설정하기") {
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
    
    
    
}

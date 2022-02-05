//
//  HomeViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/22.
//

import UIKit
import SnapKit
import Toast
import MapKit


class HomeViewController: UIViewController, UiViewProtocol {
    
    let mapView = MKMapView()
    
    let floatingButton = UIButton().then {
        $0.setImage(UIImage(named: "floatingButton_default"), for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = $0.frame.size.width/2
    }
    
    let locationManager = CLLocationManager()
    var myLocation: CLLocation!
    let sesacCampusCoordinate = CLLocationCoordinate2D(latitude: 37.51818789942772, longitude: 126.88541765534976)
    let sesacCampusCoordinate2 = CLLocationCoordinate2D(latitude: 37.516535, longitude: 126.886466)
    let sesacCampusCoordinate3 = CLLocationCoordinate2D(latitude: 37.516509, longitude: 126.885025)

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        monitorNetwork()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitorNetwork()
        view.backgroundColor = .white
        
        addViews()
        addConstraints()
        configViews()
        
        locationSettings()
        
        floatingButton.addTarget(self, action: #selector(findMyLocation), for: .touchUpInside)
    
//        withdrawButton.addTarget(self, action: #selector(onWithdrawButtonClicked), for: .touchUpInside)
        
    }
    
    func addViews() {
        view.addSubview(mapView)
        view.addSubview(floatingButton)
    }
    
    func addConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        floatingButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(64)
        }
    }
    
    func configViews() {
        
    }
    
    func locationSettings() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // 권한 요청
        
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        myLocation = locationManager.location
        
        mapView.setRegion(MKCoordinateRegion(center: sesacCampusCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true) // 현재 지도 상태를 set(위치, 축척)
        
        mapView.delegate = self
        
        addPin()
        addCustomPin(sesac_image: 1, coordinate: sesacCampusCoordinate2)
        addCustomPin(sesac_image: 2, coordinate: sesacCampusCoordinate3)

        
    }
    
    func addPin() {
        let pin = MKPointAnnotation()
        pin.coordinate = sesacCampusCoordinate
        mapView.addAnnotation(pin)
    }
    
    func addCustomPin(sesac_image: Int, coordinate: CLLocationCoordinate2D) {
       let pin = CustomAnnotation(sesac_image: sesac_image, coordinate: coordinate)
        mapView.addAnnotation(pin)
    }

}

extension HomeViewController: CLLocationManagerDelegate {
    
    // MARK: iOS 버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
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
    
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation() // 위치 접근 시작! -> didUpdateLocations 실행
        case .restricted, .denied:
            goToSetting()
        case .authorizedAlways:
            print("always")
        case .authorizedWhenInUse:
            print("wheninuse")
            locationManager.startUpdatingLocation() // 위치 접근 시작! -> didUpdateLocations 실행
        @unknown default:
            print("unknown")
        }
        
        // 정확도 체크 : 정확도 감소가 되어있을 경우, 1시간에 4번으로 제한, 미리 알림등이 제한, 배터리는 오래쓸수있음, 워치 7부터
        if #available(iOS 14.0, *) {
            let accuracyState = locationManager.accuracyAuthorization
            switch accuracyState {
            case .fullAccuracy:
                print("full")
            case .reducedAccuracy:
                print("reduced")
            @unknown default:
                print("Unknown")
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    func checkUserLocationServicesAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus)
        }
    }
    
    
    func goToSetting() {
        
        let alert = UIAlertController(title: "위치권한 요청", message: "러닝 거리 기록을 위해 항상 위치 권한이 필요합니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "설정", style: .default) { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { UIAlertAction in
            
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @objc func findMyLocation() {
        
        guard let currentLocation = locationManager.location else {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        myLocation = currentLocation
        
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
    }
    
    
}

// annotaion에 대한 뷰(커스텀)
extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        print("annotation is", annotation)
        
        guard let annotation = annotation as? CustomAnnotation else {
            return nil
        }
        
        // MARK: register를 해제하며 오류해결
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
            annotationView?.canShowCallout = false
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView?.contentMode = .scaleAspectFit
            
            let sesacImage: UIImage!
            let size = CGSize(width: 85, height: 85)
            UIGraphicsBeginImageContext(size)
            
            switch annotation.sesac_image {
            case 0:
                sesacImage = UIImage(named: "sesac_face_1")
            case 1:
                sesacImage = UIImage(named: "sesac_face_2")
            case 2:
                sesacImage = UIImage(named: "sesac_face_3")
            case 3:
                sesacImage = UIImage(named: "sesac_face_4")
            default:
                sesacImage = UIImage(named: "sesac_face_1")
            }
            
            sesacImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            annotationView?.image = resizedImage

            
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
        
        /*
        view = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
        view.canShowCallout = false
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        view.contentMode = .scaleAspectFit
        
        let sesacImage: UIImage!
        let size = CGSize(width: 85, height: 85)
        UIGraphicsBeginImageContext(size)
        
        switch annotation.sesac_image {
        case 0:
            sesacImage = UIImage(named: "sesac_face_1")
        case 1:
            sesacImage = UIImage(named: "sesac_face_2")
        case 2:
            sesacImage = UIImage(named: "sesac_face_3")
        case 3:
            sesacImage = UIImage(named: "sesac_face_4")
        default:
            sesacImage = UIImage(named: "sesac_face_1")
        }
        
        sesacImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        view.image = resizedImage
        
        return view
         */
            
            
       
        
        
    }
    
    
    
}


class CustomAnnotationView: MKAnnotationView {
    
    static let identifier = "CustomAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?){
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
    }
    
}


class CustomAnnotation: NSObject, MKAnnotation {
  let sesac_image: Int?
  let coordinate: CLLocationCoordinate2D

  init(
    sesac_image: Int?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.sesac_image = sesac_image
    self.coordinate = coordinate

    super.init()
  }

}


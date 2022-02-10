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
    
    let mapView = MKMapView().then {
        $0.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 500, maxCenterCoordinateDistance: 30000)
    }
    
    let genderButtonStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    let searchManButton = MainButton(type: .inactiveButton).then {
        $0.setTitle("남자", for: .normal)
        $0.addTarget(self, action: #selector(onSearchGenderButtonClicked(sender:)), for: .touchUpInside)
        $0.tag = GenderCase.man.rawValue
    }
    
    let searchWomanButton = MainButton(type: .inactiveButton).then {
        $0.setTitle("여자", for: .normal)
        $0.addTarget(self, action: #selector(onSearchGenderButtonClicked(sender:)), for: .touchUpInside)
        $0.tag = GenderCase.woman.rawValue
    }
    
    // default is all
    let searchAllButton = MainButton(type: .fill).then {
        $0.setTitle("전체", for: .normal)
        $0.addTarget(self, action: #selector(onSearchGenderButtonClicked(sender:)), for: .touchUpInside)
        $0.tag = GenderCase.all.rawValue
    }
    
    let centerLocationView = UIImageView().then {
        $0.image = UIImage(named: "map_marker")
    }
    
    
    let floatingButton = UIButton().then {
        $0.setImage(UIImage(named: "floatingButton_default"), for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = $0.frame.size.width/2
    }
    
    let myLocationButton = UIButton().then {
        $0.setImage(UIImage(named: "myLocation"), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
    }
    
    let locationManager = CLLocationManager()
    var myLocation: CLLocation!
    let sesacCampusCoordinate = CLLocationCoordinate2D(latitude: 37.517819364682694, longitude: 126.88647317074734)
    let sesacCampusCoordinate2 = CLLocationCoordinate2D(latitude: 37.516535, longitude: 126.886466)
    let sesacCampusCoordinate3 = CLLocationCoordinate2D(latitude: 37.516509, longitude: 126.885025)
    
    var viewModel = HomeViewModel.shared
    
    var manAnnotations: [CustomAnnotation] = []
    var womanAnnotations: [CustomAnnotation] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        monitorNetwork()
        
        checkMyStatus()
        
        DispatchQueue.main.async {
            self.viewModel.getUserInfo { userInfo, statuscode, error in
                
                guard let userInfo = userInfo else {
                    return
                }
                
                if userInfo.fcMtoken != UserDefaults.standard.string(forKey: UserDefaultKeys.FCMToken.rawValue) {
                    
                    self.updateFCMToken(newFCMToken: UserDefaults.standard.string(forKey: UserDefaultKeys.FCMToken.rawValue)!)
                    
                }
            }
        }
        
        // MARK: 다른 화면에서 홈 화면으로 전환되었을 때
        searchNearFriends()
        
        viewModel.myStatus.bind {
            switch $0 {
            case MyStatusCase.matching.rawValue:
                self.floatingButton.setImage(UIImage(named: "floatingButton_matching"), for: .normal)
            case MyStatusCase.matching.rawValue:
                self.floatingButton.setImage(UIImage(named: "floatingButton_matched"), for: .normal)
            default:
                self.floatingButton.setImage(UIImage(named: "floatingButton_default"), for: .normal)

            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitorNetwork()
        view.backgroundColor = .white
        
        addViews()
        addConstraints()
        
        locationSettings()
        
        myLocationButton.addTarget(self, action: #selector(myLocationButtonClicked), for: .touchUpInside)
        floatingButton.addTarget(self, action: #selector(onFloatginButtonClicked), for: .touchUpInside)
    
        viewModel.myStatus.bind {
            switch $0 {
            case MyStatusCase.matching.rawValue:
                self.floatingButton.setImage(UIImage(named: "floatingButton_matching"), for: .normal)
            case MyStatusCase.matching.rawValue:
                self.floatingButton.setImage(UIImage(named: "floatingButton_matched"), for: .normal)
            default:
                self.floatingButton.setImage(UIImage(named: "floatingButton_default"), for: .normal)

            }
        }
        
    }
    
    func addViews() {
        view.addSubview(mapView)
        view.addSubview(floatingButton)
        view.addSubview(myLocationButton)
        view.addSubview(genderButtonStackView)
        genderButtonStackView.addArrangedSubview(searchAllButton)
        genderButtonStackView.addArrangedSubview(searchManButton)
        genderButtonStackView.addArrangedSubview(searchWomanButton)
        
        view.addSubview(centerLocationView)
    }
    
    func addConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        floatingButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(64)
        }
        genderButtonStackView.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        searchManButton.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        
        myLocationButton.snp.makeConstraints { make in
            make.top.equalTo(genderButtonStackView.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(48)
        }
        
        centerLocationView.snp.makeConstraints { make in
            make.centerX.equalTo(mapView)
            make.centerY.equalTo(mapView).offset(-24)
            make.size.equalTo(48)
        }
        
    }
    
    
    func locationSettings() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // 권한 요청
        
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        myLocation = locationManager.location
        
        mapView.setRegion(MKCoordinateRegion(center: sesacCampusCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true) // 현재 지도 상태를 set(위치, 축척)
        
        mapView.delegate = self
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: CustomAnnotationView.identifier)
        
    }
    
    
    
    func addFilteredPin(gender: Int){
        // MARK: 전체 삭제 -> 새로 찍기(안하면 겹침)
        mapView.removeAnnotations(self.mapView.annotations)
        
        switch gender {
        case GenderCase.man.rawValue:
            mapView.addAnnotations(manAnnotations)
        case GenderCase.woman.rawValue:
            mapView.addAnnotations(womanAnnotations)
        default:
            mapView.addAnnotations(manAnnotations)
            mapView.addAnnotations(womanAnnotations)
        }
    }
    
    func checkMyStatus() {
        let myStatus = UserDefaults.standard.integer(forKey: UserDefaultKeys.myStatus.rawValue)
        viewModel.myStatus.value = myStatus
        
    }
    
    func updateFCMToken(newFCMToken: String) {
        UserAPISevice.updateFCMToken(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!, fcmToken: newFCMToken) { statuscode in
            
            switch statuscode {
            case UserStatusCodeCase.success.rawValue:
                self.viewModel.getUserInfo { userInfo, statuscode, error in
                    
                }
            case UserStatusCodeCase.firebaseTokenError.rawValue:
                self.refreshFirebaseIdToken { idtoken, error in
                    UserAPISevice.updateFCMToken(idToken: idtoken!, fcmToken: UserDefaults.standard.string(forKey: UserDefaultKeys.FCMToken.rawValue)!) { statuscode in
                    }
                }
            default:
                print("updateFCMToken error ", statuscode)
            }
            
        }
    }
    
    // MARK: 성별 필터 버튼을 클릭할 때
    @objc func onSearchGenderButtonClicked(sender: MainButton) {
        searchManButton.style = .inactiveButton
        searchWomanButton.style = .inactiveButton
        searchAllButton.style = .inactiveButton
        
        sender.style = .fill
        viewModel.searchGender.value = sender.tag
        
        searchNearFriends()
        
      
    }
    
    @objc func onFloatginButtonClicked() {
        
        checkUserLocationServiceAuthoriztaion()
        
        if viewModel.isLocationEnable.value == false {
            return
        }
        
        if viewModel.myUserInfo.value.gender == GenderCase.unselected.rawValue {
            view.makeToast("새싹 찾기 기능을 이용하기 위해서는 성별 설정이 필요해요!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.present(ProfileDetailViewController(), animated: true, completion: nil)
            }
        } else {
            let modalVC = HomeHobbyViewController()
            modalVC.modalPresentationStyle = .fullScreen
            self.present(modalVC, animated: true, completion: nil)
//            self.navigationController?.pushViewController(HomeHobbyViewController(), animated: true)
        }
        
        switch viewModel.myStatus.value {
        case MyStatusCase.matching.rawValue:
            print("")
        case MyStatusCase.matched.rawValue:
            print("")
        default:
            print("")
        }
        
    }
    
    @objc func myLocationButtonClicked() {
        guard let currentLocation = locationManager.location else {
            locationManager.requestWhenInUseAuthorization()
            goToSetting()
            return
        }
        
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
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
            view.makeToast("ios 위치 서비스를 켜주세요")
        }
        
    }
    
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("notDetermined")
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation() // 위치 접근 시작! -> didUpdateLocations 실행
        case .restricted, .denied:
            print("LocationDisable")
            viewModel.isLocationEnable.value = false
            viewModel.calculateRegion(lat: 37.517819364682694, long: 126.88647317074734)
            goToSetting()
        case .authorizedAlways, .authorizedWhenInUse:
            print("LocationEnable")
            viewModel.isLocationEnable.value = true
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
        checkUserLocationServicesAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
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
            searchNearFriends()
        }
    }
    
    
    func goToSetting() {
        
        let alert = UIAlertController(title: "위치 권한 요청", message: "위치 서비스 사용 불가.", preferredStyle: .alert)
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
    
    func searchNearFriends() {
        
        let form = OnQueueForm(region: viewModel.centerRegion.value, lat: viewModel.centerLat.value, long: viewModel.centerLong.value)
        viewModel.searchNearFriends(form: form) { onqueueResult, statuscode, error in
            
            switch statuscode {
            case OnQueueStatusCodeCase.success.rawValue:
                guard let onqueueResult = onqueueResult else {
                    return
                }
                
                // 초기화
                self.manAnnotations = []
                self.womanAnnotations = []
                
                print(onqueueResult)
                
                // MARK: onqueue의 결과를 VM에 저장
                for otherUserInfo in onqueueResult.fromQueueDB {
                    
                    self.viewModel.fromNearFriendsHobby.value.append(contentsOf: otherUserInfo.hf)
                    
                    self.viewModel.fromNearFriendsHobby.value = Array(Set(self.viewModel.fromNearFriendsHobby.value))
                
                    if otherUserInfo.gender == GenderCase.man.rawValue {
                        self.manAnnotations.append(CustomAnnotation(sesac_image: otherUserInfo.sesac, coordinate: CLLocationCoordinate2D(latitude: otherUserInfo.lat, longitude: otherUserInfo.long)))
                    } else {
                        self.womanAnnotations.append(CustomAnnotation(sesac_image: otherUserInfo.sesac, coordinate: CLLocationCoordinate2D(latitude: otherUserInfo.lat, longitude: otherUserInfo.long)))
                    }
                }
                
                for otherUserInfo in onqueueResult.fromQueueDBRequested {
                    
                    self.viewModel.fromNearFriendsHobby.value.append(contentsOf: otherUserInfo.hf)
                    
                    self.viewModel.fromNearFriendsHobby.value = Array(Set(self.viewModel.fromNearFriendsHobby.value))
                    
                    if otherUserInfo.gender == GenderCase.man.rawValue {
                        self.manAnnotations.append(CustomAnnotation(sesac_image: otherUserInfo.sesac, coordinate: CLLocationCoordinate2D(latitude: otherUserInfo.lat, longitude: otherUserInfo.long)))
                    } else {
                        self.womanAnnotations.append(CustomAnnotation(sesac_image: otherUserInfo.sesac, coordinate: CLLocationCoordinate2D(latitude: otherUserInfo.lat, longitude: otherUserInfo.long)))
                    }
                }
                
                self.viewModel.fromRecommendHobby.value =  onqueueResult.fromRecommend
                
                print("man:", self.manAnnotations)
                print("woman:", self.womanAnnotations)
                
                self.addFilteredPin(gender: self.viewModel.searchGender.value)
                
                
            case OnQueueStatusCodeCase.firebaseTokenError.rawValue:
                // 토큰 만료 -> 갱신
                self.refreshFirebaseIdToken { idToken, error in
                    if let idToken = idToken {
                        self.searchNearFriends()
                    }
                }
            default:
                self.view.makeToast("주변 새싹 친구를 찾는데 실패했습니다. 잠시 후 다시 시도해주세요")
            }
        }
    }
    
    
    
}

// annotaion에 대한 뷰(커스텀)
extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CustomAnnotation else {
            return nil
        }
        
        // MARK: register에서 오류가 발생했었음
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
            annotationView?.canShowCallout = false
            annotationView?.contentMode = .scaleAspectFit
            
        } else {
            annotationView?.annotation = annotation
        }
        
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
        case 4:
            sesacImage = UIImage(named: "sesac_face_5")
        default:
            sesacImage = UIImage(named: "sesac_face_1")
        }
        
        sesacImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView?.image = resizedImage
        
        return annotationView
            
            
    }
    // MARK: 사용자가 움직일 때
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        print("region is",region)
        
        viewModel.calculateRegion(lat: lat, long: long)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    // MARK: region이 바뀔 때(지도를 움직임)
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let lat = mapView.centerCoordinate.latitude
        let long = mapView.centerCoordinate.longitude
    
        let center = CLLocation(latitude: lat, longitude: long)
        print("center is",center)
        
        viewModel.calculateRegion(lat: lat, long: long)
        
        // MARK: gps버튼, 사용자가 맵 이동, 위치 업데이트,
        searchNearFriends()
        
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


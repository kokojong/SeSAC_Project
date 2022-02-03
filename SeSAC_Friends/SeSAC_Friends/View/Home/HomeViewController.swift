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
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        myLocation = locationManager.location
        
    
//        withdrawButton.addTarget(self, action: #selector(onWithdrawButtonClicked), for: .touchUpInside)
        
    }
    
    func addViews() {
        view.addSubview(mapView)
        view.addSubview(floatingButton)
    }
    
    func addConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        floatingButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(64)
        }
    }
    
    func configViews() {
        
    }
    
    @objc func onWithdrawButtonClicked() {
        
        UserAPISevice.withdrawSignUp(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!) { statuscode, error in
            self.view.makeToast("탈퇴 결과 코드 : \(statuscode)\n첫 화면으로 이동합니다")
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = OnboardingViewController()
                windowScene.windows.first?.makeKeyAndVisible()
                UIView.transition(with: windowScene.windows.first!, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
        }
        
    }
    

}

extension HomeViewController: CLLocationManagerDelegate {
    
    
    
    
}

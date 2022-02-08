//
//  ViewController+Extension.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/23.
//

import Foundation
import UIKit
import Network
import Toast
import FirebaseAuth

extension UIViewController {
    
    func monitorNetwork(){
            
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = {
            path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
//                    self.view.makeToast(path.usesInterfaceType(<#T##type: NWInterface.InterfaceType##NWInterface.InterfaceType#>))
                    return
                }
            } else {
                DispatchQueue.main.async {
                    self.view.makeToast("네트워크 연결이 원활하지 않습니다.\n 연결상태 확인 후 다시 시도해 주세요!")
                }
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    
    func setNavBackArrowButton() {
        let bakcArrowButton = UIBarButtonItem(image: UIImage(named: "arrow_back"), style: .done, target: self, action: #selector(onNavBackArrowButtonClicked))
        bakcArrowButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = bakcArrowButton
        
    }
    
    @objc func onNavBackArrowButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func refreshFirebaseIdToken(completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            
            if let error = error {
                self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요.")
                completion(nil, error)
                return
            }

            if let idToken = idToken {
                UserDefaults.standard.set(idToken, forKey: UserDefaultKeys.idToken.rawValue)
                completion(idToken,nil)
                
            }
    
        }
    }
    
    
    
}





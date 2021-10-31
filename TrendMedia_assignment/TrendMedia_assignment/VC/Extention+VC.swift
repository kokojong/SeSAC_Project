//
//  Extention+VC.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/30.
//

import Foundation
import UIKit
import Network

extension UIViewController {

    func networkMonitor() {
        
        // 네트워크 변경 감지 클래스
        let networkMonitor = NWPathMonitor()
        
        networkMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Network Connected")
                
                if path.usesInterfaceType(.cellular) {
                    print("Cellular")
                } else if path.usesInterfaceType(.wifi) {
                    print("Wi-Fi")
                } else {
                    print("Others")
                }
                
            } else {
                print("Network Disconnected")
                self.showAlert(title: "네트워크 오류", message: "네트워크 상태를 확인해주세요" )
                
            }
        }
        
        networkMonitor.start(queue: DispatchQueue.global())
        
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)

            alert.addAction(ok)
            
            self.present(alert, animated: true) {
                print("alert 띄움")
            }
    }
}

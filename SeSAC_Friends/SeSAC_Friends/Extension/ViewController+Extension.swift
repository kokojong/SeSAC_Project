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

extension UIViewController {
    
    func monitorNetwork(){
            
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = {
            path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
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
    
}





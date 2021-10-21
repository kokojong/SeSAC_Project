//
//  Alert+Extension.swift
//  SeSAC_week4
//
//  Created by kokojong on 2021/10/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, okTitle: String, okAction: @escaping () -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        
        let ok = UIAlertAction(title: okTitle, style: .default) { _ in
            print("확인 버튼")
            
            okAction()
            
        }

        
        alert.addAction(cancle)
        alert.addAction(ok)
        
        self.present(alert, animated: true) {
            print("alert 띄움")
        }
    }
    
}

//
//  CommonMethod.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/01.
//

import Foundation
import UIKit
 
func changeRootView(vc: UIViewController){
    
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: vc)
    windowScene.windows.first?.makeKeyAndVisible()
    
    UIView.transition(with: windowScene.windows.first!, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
}

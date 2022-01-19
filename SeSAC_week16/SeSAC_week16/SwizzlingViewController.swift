//
//  SwizzlingViewController.swift
//  SeSAC_week16
//
//  Created by kokojong on 2022/01/10.
//

import UIKit

class SwizzlingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

            
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
        
        
    }
    
}

extension UIViewController {
    // 메서드 -> 런타임 실행 메서드
    // #selector -> 런타임에서 어떤 함수를 실행할지 찾음
    class func swizzleMethod() {
        
        let origin = #selector(viewWillAppear(_:))
        let change = #selector(changedViewWillAppear)
        
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin), let changedMethod = class_getInstanceMethod(UIViewController.self, change) else {
            print("함수를 찾을 수 없거나 오류")
            return
        }
        
        method_exchangeImplementations(originMethod, changedMethod)
    }
            
    // 여기에 analytics를 달고 싶다면 swizzleMethod를 통해서 가능
    @objc func changedViewWillAppear() {
        print("changedViewWillAppear") // 버전이 달라지면 오류가 생길 수 있음, 메서드에서 예상할수 없는 에러 발생 가능
    }
}

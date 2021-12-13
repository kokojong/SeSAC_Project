//
//  ViewController.swift
//  SeSAC_week11_firebase
//
//  Created by kokojong on 2021/12/06.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
        button.setTitle("Test Crash", for: [])
        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
//          AnalyticsParameterItemID: "id-\(title)",
//          AnalyticsParameterItemName: title,
//          AnalyticsParameterContentType: "cont",
//        ])
        
        Analytics.logEvent("share_image", parameters: [
          "name": "kokojong" as NSObject,
          "full_text": "test" as NSObject,
        ])
    }

    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        fatalError()
//      let numbers = [0]
//      let _ = numbers[1]
    }

}


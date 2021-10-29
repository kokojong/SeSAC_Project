//
//  PapagoViewController.swift
//  SeSAC_week5_network
//
//  Created by kokojong on 2021/10/26.
//

import UIKit
import Network

import Alamofire
import SwiftyJSON


class PapagoViewController: UIViewController {

    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var targetTextView: UITextView!
    
    var translateText: String = "" { // 옵저버를 달아줌
        didSet {
            targetTextView.text = translateText // 와 신세계
        }
    }
    
    // 네트워크 변경 감지 클래스
    let networkMonitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            }
        }
        
        networkMonitor.start(queue: DispatchQueue.global())
        
    }
    


    @IBAction func onTranslateButtonClicked(_ sender: UIButton) {
    
        guard let text = sourceTextView.text else { return }
            
        DispatchQueue.global().async {
            TranslatedAPIManager.shared.fetchTranslatedData(text: text) { code, json in
                
                switch code {
                case 200:
                    print(json)
                    DispatchQueue.main.async {
                        self.translateText = json["message"]["result"]["translatedText"].stringValue
                    }
                    
                case 400:
                    print(json)
                    self.translateText = json["errorMessage"].stringValue
                default:
                    print("error")
                
                }
            }
        }
        
        
        
        
        
    }
}

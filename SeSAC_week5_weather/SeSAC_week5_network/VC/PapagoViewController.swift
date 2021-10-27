//
//  PapagoViewController.swift
//  SeSAC_week5_network
//
//  Created by kokojong on 2021/10/26.
//

import UIKit
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    


    @IBAction func onTranslateButtonClicked(_ sender: UIButton) {
    
        guard let text = sourceTextView.text else { return }
        TranslatedAPIManager.shared.fetchTranslatedData(text: text) { code, json in
            
            switch code {
            case 200:
                print(json)
                self.translateText = json["message"]["result"]["translatedText"].stringValue
            case 400:
                print(json)
                self.translateText = json["errorMessage"].stringValue
            default:
                print("error")
            
            }
        }
        
    }
}

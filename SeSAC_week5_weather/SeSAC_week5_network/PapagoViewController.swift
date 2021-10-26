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
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    


    @IBAction func onTranslateButtonClicked(_ sender: UIButton) {
    
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id":"sHXg6cdzeK4giS0SuZA2",
            "X-Naver-Client-Secret":"yrsXMsOkxI"
        ]
        let parameters = [
            "source": "ko",
            "target": "en",
            "text": sourceTextView.text!
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                self.targetTextView.text = json["message"]["result"]["translatedText"].stringValue
            case .failure(let error):
                print(error)
            }
        }
        
        

    
    }
}

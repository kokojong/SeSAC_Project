//
//  OCRViewController.swift
//  SeSAC_week5_network
//
//  Created by kokojong on 2021/10/27.
//

import UIKit

class OCRViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var resultTextView: UITextView!
    
    var wordList: [String] = []
    var resultSting: String = "" {
        didSet{
            resultTextView.text = resultSting
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func onOCRButtonClicked(_ sender: UIButton) {
        OCR_APIManager.shared.fetchOCRData(image: mainImageView.image!) { json in
            print(json)
            
            for item in json["result"].arrayValue {
//                self.wordList.append(item["recognition_words"][0].stringValue)
                self.resultSting += item["recognition_words"][0].stringValue+"\n"
            }
            
            self.resultTextView.text = self.resultSting
            
            
        }
        
    }
    
}

//
//  SecondViewController.swift
//  SeSAC_week7_cocoapods
//
//  Created by kokojong on 2021/11/10.
//

import UIKit

protocol PassDataDelegate {
    func sendTextData(text: String)
}

class SecondViewController: UIViewController {

    @IBOutlet weak var secondTextView: UITextView!
    
    var textSpace: String = ""
    
    var buttonActionHandler: (() -> ())?
    
    var delegate: PassDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        secondTextView.text = textSpace
        // Do any additional setup after loading the view.
        
//        NotificationCenter.default.addObserver(self, selector: #selector(firstNotification(notification:)), name: NSNotification.Name("firstNotification"), object: nil)
    
    }
    
//    @objc func firstNotification(notification: NSNotification) {
//        print("firstNotification")
//    }
    

    @IBAction func onXButtonClicked(_ sender: UIButton) {
        
        buttonActionHandler?()
        
        // 나를 불러온 VC(first)
        guard let presentVC = self.presentingViewController else { return }
        
        self.dismiss(animated: true) {
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopupViewController") as? PopupViewController else { return }
            
            presentVC.present(vc, animated: true, completion: nil)
            
            print("dismiss")
            
        }
        
    }
    
    @IBAction func onNotificationButtonClicked(_ sender: UIButton) {
    
        NotificationCenter.default.post(name: NSNotification.Name("firstNotification"), object: nil, userInfo: ["myText" : secondTextView.text!, "value" : 123])
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onProtocolButtonClicked(_ sender: UIButton) {
    
        if let text = secondTextView.text {
            delegate?.sendTextData(text: text)
        }
            
        
        dismiss(animated: true, completion: nil)
    }
}

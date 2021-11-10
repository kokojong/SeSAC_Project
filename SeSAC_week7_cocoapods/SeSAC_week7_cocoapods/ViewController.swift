//
//  ViewController.swift
//  SeSAC_week7_cocoapods
//
//  Created by kokojong on 2021/11/10.
//

import UIKit

class ViewController: UIViewController, PassDataDelegate {
    
    func sendTextData(text: String) {
        firstTextView.text = text // 받아온거 보여주기
    }
    
    @IBOutlet weak var firstTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(firstNotification(notification:)), name: NSNotification.Name("firstNotification"), object: nil)
    }
    
    @objc func firstNotification(notification: NSNotification) {
        print("firstNotification")
        
        if let text = notification.userInfo?["myText"] as? String {
            firstTextView.text = text
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 이렇게 한다면 중복으로 옵저버가 만들어진다
//        NotificationCenter.default.addObserver(self, selector: #selector(firstNotification(notification:)), name: NSNotification.Name("firstNotification"), object: nil)
    }
    
    // 중복된 옵저버 제거하기
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    // 중복된 옵저버 제거하기
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("firstNotification"), object: nil)
//    }
    

    @IBAction func onButtonClicked(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        
        vc.textSpace = firstTextView.text
        vc.buttonActionHandler = {
            //
            self.firstTextView.text = vc.secondTextView.text
            print("buttonActionHandler")
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func onNotificationButtonClicked(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: NSNotification.Name("firstNotification"), object: nil, userInfo: ["myText" : firstTextView.text!, "value" : 123])
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        
        modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func onProtocolButtonClicked(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        
        vc.delegate = self // 다른 버튼으로 눌러서 secondVC로 간다면 delegate연결 x
        
        self.present(vc, animated: true, completion: nil)
    }
}

extension NSNotification.Name {
    static let myNotification = NSNotification.Name("firstNotification")
}

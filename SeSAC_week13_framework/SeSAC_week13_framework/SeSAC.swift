//
//  SeSAC.swift
//  SeSAC_week13_framework
//
//  Created by kokojong on 2021/12/23.
//

import Foundation
import UIKit
import WebKit

open class openVCTest : UIViewController {
    
    private var name = "kokojong"
    
    open func openFunction() {
        
    }
    
    public func presentWebViewController(url: String, transitionStyle: TransitionStyle, vc: UIViewController) {
        let webViewController = WebViewController()
        webViewController.url = url
        switch transitionStyle {
        case .present:
            vc.present(webViewController, animated: true, completion: nil)
        case .push:
            vc.navigationController?.pushViewController(webViewController, animated: true)
        }
        
    }
    
    public enum TransitionStyle {
        case present, push
    }
}

class WebViewController: UIViewController, WKUIDelegate {
    
    var url: String = "https://www.apple.com"
    
    var webView: WKWebView!
            
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

public class publicVCTest : UIViewController {
    
    var name = "kokojong2"
    
    func publicFunction() {
        
    }
}

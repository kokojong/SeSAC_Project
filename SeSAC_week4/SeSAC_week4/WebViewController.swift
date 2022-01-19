//
//  WebViewController.swift
//  SeSAC_week4
//
//  Created by kokojong on 2021/10/19.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var urlSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        urlSearchBar.delegate = self
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        webView.stopLoading()
    
    }
    
    @IBAction func goBackButtonClicked(_ sender: UIBarButtonItem) {
        webView.goBack()
    
    }
    
    @IBAction func reloadButtonClicked(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func goForwardButtonClicked(_ sender: UIBarButtonItem) {
        webView.goForward()
        
    }
}

extension WebViewController: UISearchBarDelegate{
    
    // 서치바에서 검색 리턴키 클릭
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let url = URL(string: searchBar.text ?? "") else {
            print("Error")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
        
                
        
    }
    
}

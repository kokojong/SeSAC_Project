//
//  WebViewController.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/18.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var mainWebView: WKWebView!
    
    static let identifier = "WebViewController"
    
    var tvShowData : TvShow?
    
    var trendMediaTVData : TrendMediaTVModel?
    
    var tvshowURL: String = "" {
        didSet {
            loadWebView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = trendMediaTVData?.original_name
        
        loadTVshowVideo()
    }
    
    func loadTVshowVideo () {
        TrendMediaVideoAPIManager.shared.fetchTrendMediaCreditsData(movie_id: trendMediaTVData!.id) { json in
            
            self.tvshowURL =  json["results"][0]["key"].stringValue
            
        }
    }
    
    func loadWebView() {
        
        let videoUrl = "https://www.youtube.com/watch?v=" + tvshowURL
        
        let url = URL(string: videoUrl)
        
        let request = URLRequest(url: url!)
        
        DispatchQueue.main.async {
            self.mainWebView.load(request)
        }
        
    }
    
}

//
//  WebViewController.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/18.
//

import UIKit

class WebViewController: UIViewController {
    
    var tvShowData : TvShow?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = tvShowData?.title

        
    }
    


}

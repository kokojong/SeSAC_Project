//
//  ContentViewController.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "content"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action:#selector(closeButtonClicked) )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked) )
    }
    
    @objc func closeButtonClicked() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func saveButtonClicked() {
        
        print("saved")
        
    }
    
}

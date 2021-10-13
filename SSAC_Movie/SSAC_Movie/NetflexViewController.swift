//
//  NetflexViewController.swift
//  SSAC_Movie
//
//  Created by kokojong on 2021/09/29.
//

import UIKit

class NetflexViewController: UIViewController {

    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var previewImageVIew1: UIImageView!
    @IBOutlet weak var previewImageVIew2: UIImageView!
    @IBOutlet weak var previewImageVIew3: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewImageVIew1.layer.cornerRadius = previewImageVIew1.frame.height / 2
        previewImageVIew1.layer.borderColor = UIColor.gray.cgColor
        previewImageVIew1.layer.borderWidth = 5
        
        previewImageVIew2.layer.cornerRadius = previewImageVIew2.frame.height / 2
        previewImageVIew2.layer.borderColor = UIColor.gray.cgColor
        previewImageVIew2.layer.borderWidth = 5
        
        
        previewImageVIew2.layer.cornerRadius = previewImageVIew2.frame.height / 2
        previewImageVIew2.layer.borderColor = UIColor.gray.cgColor
        previewImageVIew2.layer.borderWidth = 5
        
        changeImages()
//        previewImageVIew1.image = UIImage.init(named: "poster5")
   
    }
    
    @IBAction func onPlayButtonClicked(_ sender: UIButton) {
        changeImages()
    }
    
    fileprivate func getRandomImage() -> String{
        let imgs = ["poster1","poster2","poster3","poster4","poster5","poster6","poster7","poster8","poster9","poster10"]
        let img = imgs[Int.random(in: 0...9)]
        
        return img
    }
    
    fileprivate func changeImages() {
        mainImageView.image = UIImage.init(named: getRandomImage())
        previewImageVIew1.image = UIImage.init(named: getRandomImage())
        previewImageVIew2.image = UIImage.init(named: getRandomImage())
        previewImageVIew3.image = UIImage.init(named: getRandomImage())
    
    }
    
}

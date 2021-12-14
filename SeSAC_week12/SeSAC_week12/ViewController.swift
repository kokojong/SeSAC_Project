//
//  ViewController.swift
//  SeSAC_week12
//
//  Created by kokojong on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var favoriteMenuView: SquareBoxView!
    
    let redView: UIView = UIView()
    let greenView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greenView.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(blueView)
        greenView.clipsToBounds = true
//        redView.alpha = 0.5
//
//        greenView.layer.allowsGroupOpacity = true
        
        redView.backgroundColor = .red
        redView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        
        greenView.backgroundColor = .green
        greenView.frame = CGRect(x: 100, y: 100, width: 150, height: 150)
        
        blueView.backgroundColor = .blue
        blueView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        favoriteMenuView.label.text = "즐겨찾기"
        favoriteMenuView.imageView.image = UIImage(systemName: "heart.fill")
    }

    @IBAction func onButtonClicked(_ sender: UIButton) {
        
        present(DetailViewController(), animated: true, completion: nil)
    }
    
}


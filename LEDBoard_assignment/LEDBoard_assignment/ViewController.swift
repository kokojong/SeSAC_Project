//
//  ViewController.swift
//  LEDBoard_assignment
//
//  Created by kokojong on 2021/10/01.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var changColorButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTopView()
        setSearchTextField()
        setSendButton()
        setChangeColorButton()
    
        
        mainLabel.adjustsFontSizeToFitWidth = true
        mainLabel.minimumScaleFactor = 0.001
    }
    
    fileprivate func setTopView(){
        topView.layer.cornerRadius = 10
    }
    
    fileprivate func setSearchTextField(){
        searchTextField.placeholder = "텍스트를 입력해주세요"
        searchTextField.borderStyle = .none
        
    }
    
    fileprivate func setSendButton(){
        sendButton.layer.cornerRadius = 10
        sendButton.layer.borderColor = UIColor.black.cgColor
        sendButton.layer.borderWidth = 2
        sendButton.setTitle("보내기", for:.normal)
        
    }
    fileprivate func setChangeColorButton(){
        changColorButton.layer.cornerRadius = 10
        changColorButton.layer.borderColor = UIColor.black.cgColor
        changColorButton.layer.borderWidth = 2
        changColorButton.setTitle("Aa", for: .normal)
        changColorButton.tintColor = .red
        
    }
    
    fileprivate func getRandomColor() -> UIColor {
        let colors = [UIColor.systemRed, UIColor.systemBlue, UIColor.systemMint, UIColor.systemPink, UIColor.systemBrown]
        let randomNum = Int.random(in: 0...4)
        return colors[randomNum]
    }

    
    @IBAction func onReturnSearchTextField(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    @IBAction func onTapGesture(_ sender: UITapGestureRecognizer){
        topView.isHidden = !topView.isHidden
        view.endEditing(true)
    }
    @IBAction func onSendButtonClicked(_ sender: UIButton) {
        mainLabel.text = searchTextField.text
        
    }
    
    @IBAction func onColorChangeButtonClicked(_ sender: UIButton) {
        mainLabel.textColor = getRandomColor()
    }
}


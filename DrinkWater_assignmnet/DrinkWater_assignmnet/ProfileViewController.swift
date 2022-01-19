//
//  ProfileViewController.swift
//  DrinkWater_assignmnet
//
//  Created by kokojong on 2021/10/08.
//

import UIKit
import TextFieldEffects

class ProfileViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var nickname: HoshiTextField!
    @IBOutlet weak var height: HoshiTextField!
    @IBOutlet weak var weight: HoshiTextField!
    
    @IBOutlet weak var navItems: UINavigationItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var mainImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        mainView.backgroundColor = .systemGreen
        navItems.title = "프로필"
        navItems.leftBarButtonItem?.tintColor = .white
        navItems.rightBarButtonItem?.tintColor = .white
        mainImageView.image = UIImage(named: "1-1")
        
        setHoshiTextFields()
        // Do any additional setup after loading the view.
    }
    
    
    fileprivate func setHoshiTextFields(){
        nickname.font = .systemFont(ofSize: 25)
        nickname.placeholder = "닉네임을 설정해주세요"
        nickname.placeholderColor = .white
        nickname.textColor = .white
        nickname.borderStyle = .none
        nickname.borderActiveColor = .blue
        
        
        height.font = .systemFont(ofSize: 25)
        height.placeholder = "키를 입력해주세요(cm)"
        height.placeholderColor = .white
        height.textColor = .white
        height.borderStyle = .none
        height.borderActiveColor = .blue
        height.keyboardType = .numberPad
        
        
        weight.font = .systemFont(ofSize: 25)
        weight.placeholder = "몸무게를 입력해주세요(kg)"
        weight.placeholderColor = .white
        weight.textColor = .white
        weight.borderStyle = .none
        weight.borderActiveColor = .blue
        weight.keyboardType = .numberPad
    }

    
    @IBAction func onSaveButtonClicked(_ sender: UIBarButtonItem) {
        let nick = nickname.text
        UserDefaults.standard.set(nick, forKey: "name")
        
        let h : Double = Double(height.text!) ?? 160
       
        let w : Double = Double(weight.text!) ?? 50
        
        let total : Int = Int(h + w) * 10// 몇 ml를 먹어야 하는지
        UserDefaults.standard.set(total, forKey: "totalDrink")
    }
    
    @IBAction func onTapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

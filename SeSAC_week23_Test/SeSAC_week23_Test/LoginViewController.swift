//
//  LoginViewController.swift
//  SeSAC_week23_Test
//
//  Created by kokojong on 2022/03/02.
//

import UIKit


// id: @포함, 6자 이상
// pw: 6자 이상 10자리 미만
// check: pw와 같은지
class LoginViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!

    @IBOutlet weak var checkTextField: UITextField!
    
    let validator = Validator()
    var user = User(id: "", password: "", check: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        user = User(id: idTextField.text!, password: pwTextField.text!, check: checkTextField.text!)
        
        if validator.isValidID(id: user.id) && validator.isValidPW(pw: user.password) && validator.isEqualPW(pw: user.password, check: user.check) {
            print("성공")
        } else {
            print("실패")
        }
    }

//    func isValidID() -> Bool {
//        guard let id = idTextField.text else { return false }
//
//        return id.count >= 6 && id.contains("@")
//    }
//
//    func isValidPW() -> Bool {
//        guard let pw = pwTextField.text else { return false }
//
//        return pw.count >= 6 && pw.count < 10
//    }
//
//    func isEqualPW() -> Bool {
//        guard let pw = pwTextField.text, let check = checkTextField.text else { return false }
//
//        return pw == check
//    }
}

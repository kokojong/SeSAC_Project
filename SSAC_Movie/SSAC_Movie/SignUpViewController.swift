//
//  SignUpViewController.swift
//  SSAC_Movie
//
//  Created by kokojong on 2021/09/30.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var detailSwitch: UISwitch!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEmailTextField()
        setPasswordTextField()
        setNicknameTextField()
        setLocationTextField()
        setCodeTextField()
        
        setSignUpButton()
        
        setDetailSwitch()

       
    }
    fileprivate func setEmailTextField(){
        emailTextField.attributedPlaceholder = NSAttributedString(string: "이메일 주소 또는 전화번호", attributes: [.foregroundColor: UIColor.white])
        emailTextField.textColor = .white
        emailTextField.keyboardType = .default
        emailTextField.isSecureTextEntry = false
        emailTextField.textAlignment = .center
        emailTextField.borderStyle = .roundedRect
        emailTextField.backgroundColor = .darkGray
    }
    
    fileprivate func setPasswordTextField(){
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [.foregroundColor: UIColor.white])
        passwordTextField.textColor = .white
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textAlignment = .center
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = .darkGray
    }
    
    fileprivate func setNicknameTextField(){
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [.foregroundColor: UIColor.white])
        nicknameTextField.textColor = .white
        nicknameTextField.keyboardType = .default
        nicknameTextField.isSecureTextEntry = false
        nicknameTextField.textAlignment = .center
        nicknameTextField.borderStyle = .roundedRect
        nicknameTextField.backgroundColor = .darkGray
    }
    
    fileprivate func setLocationTextField(){
        locationTextField.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [.foregroundColor: UIColor.white])
        locationTextField.textColor = .white
        locationTextField.keyboardType = .default
        locationTextField.isSecureTextEntry = false
        locationTextField.textAlignment = .center
        locationTextField.borderStyle = .roundedRect
        locationTextField.backgroundColor = .darkGray
    }
    
    fileprivate func setCodeTextField() {
        codeTextField.attributedPlaceholder = NSAttributedString(string: "추천인 코드", attributes: [.foregroundColor: UIColor.white])
        codeTextField.textColor = .white
        codeTextField.keyboardType = .default
        codeTextField.isSecureTextEntry = false
        codeTextField.textAlignment = .center
        codeTextField.borderStyle = .roundedRect
        codeTextField.backgroundColor = .darkGray
    }
    fileprivate func setSignUpButton(){
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.layer.cornerRadius = 10
    }
    fileprivate func setDetailSwitch(){
        detailSwitch.setOn(true, animated: true)
        detailSwitch.onTintColor = .red
        detailSwitch.thumbTintColor = .white
    }
    @IBAction func onSignUpButtonClicked(_ sender: UIButton) {
        print("회원가입 정보 확인")
        
        let id : String? = emailTextField.text
        let pw : String? = passwordTextField.text
        let nick : String? = nicknameTextField.text
        let location : String? = locationTextField.text
        let code : String? = codeTextField.text
        
        print("ID : \(id!)")
//        print(emailTextField.text)
//        print("\(String(describing: emailTextField.text!))")
        print("PW : \(pw!))")
        print("NICK : \(nick!))")
        print("LOCATION : \(location!)")
        print("CODE : \(code!)")
    }
    
    @IBAction func onTapGesture(_ sender: Any) {
        view.endEditing(true)
    }
   
    @IBAction func onSwitch(_ sender: UISwitch) {
        if detailSwitch.isOn {
            nicknameTextField.isHidden = false
            locationTextField.isHidden = false
            codeTextField.isHidden = false
        } else {
            nicknameTextField.isHidden = true
            locationTextField.isHidden = true
            codeTextField.isHidden = true
        }
    }
}

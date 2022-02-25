//
//  ChangePWViewController.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/13.
//

import UIKit

class ChangePWViewController: UIViewController {
    
//    var viewModel: PostMainViewModel!
    var viewModel = PostMainViewModel.shared
    
    let currentPasswordTextField: UITextField = {
        let textField = UITextField()
         textField.placeholder = "현재 비밀번호"
         textField.layer.cornerRadius = 8
         textField.layer.borderWidth = 1
         textField.layer.borderColor = UIColor.lightGray.cgColor
         textField.addLeftPadding()
         return textField
    }()
    
    let newPasswordTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "새로운 비밀번호"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.addLeftPadding()
        return textField
    }()
    
    let newPasswordCheckTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "새로운 비밀번호 확인"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.addLeftPadding()
        return textField
    }()
    
    let changeButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("비밀번호 변경", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(currentPasswordTextField)
        view.addSubview(newPasswordTextField)
        view.addSubview(newPasswordCheckTextField)
        view.addSubview(changeButton)
        
        currentPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        newPasswordCheckTextField.delegate = self
        changeButton.addTarget(self, action: #selector(onChangeButtonClicked), for: .touchUpInside)
        
        currentPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
        
        newPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(currentPasswordTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
        
        newPasswordCheckTextField.snp.makeConstraints { make in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
        
        changeButton.snp.makeConstraints { make in
            make.top.equalTo(newPasswordCheckTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
    }
    
    @objc func onChangeButtonClicked() {
        self.view.endEditing(true)
        
        if currentPasswordTextField.text! == newPasswordTextField.text! {
            view.makeToast("변경할 내용이 없습니다")
            return
        }
        
        if newPasswordTextField.text! != newPasswordCheckTextField.text! {
            view.makeToast("새로운 비밀번호가 일치하지 않습니다")
            return
        }
        
       
        viewModel.changePW(currentPW: currentPasswordTextField.text!, newPW:  newPasswordTextField.text!, newPWCheck: newPasswordCheckTextField.text!) { error in
            print("changePW error",error)
            
            guard let error = error else {
                self.view.makeToast("비밀번호가 변경되었습니다")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.dismiss(animated: true, completion: nil)
                }
                return
            }
            self.view.makeToast("비밀번호 변경 중에 오류가 발생했습니다 \n비밀번호를 확인해주세요")

        }
    }

}

extension ChangePWViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.currentPasswordTextField {
            self.newPasswordTextField.becomeFirstResponder()
        } else if textField == self.newPasswordTextField {
            self.newPasswordCheckTextField.becomeFirstResponder()
        } else {
            self.newPasswordCheckTextField.resignFirstResponder()
            
        }
        
        return true
    }
    
}

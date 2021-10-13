//
//  FoodViewController.swift
//  SSAC_Food
//
//  Created by kokojong on 2021/10/01.
//

import UIKit

class FoodViewController: UIViewController {

    @IBOutlet weak var userSearchTextField: UITextField!
    
    @IBOutlet weak var tagButton1: UIButton!
    @IBOutlet weak var tagButton2: UIButton!
    @IBOutlet weak var tagButton3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // buttonOutletName : 매개변수(parameter), tagButton1 : 전달인자(argument)
        buttonUISetting(buttonOutletName: tagButton1, buttonTitle: "사탕")
        buttonUISetting(buttonOutletName: tagButton2, buttonTitle: "초콜릿")
        buttonUISetting(buttonOutletName: tagButton3, buttonTitle: "아이스크림")
    }
    
  
    // buttonOutletName 외부 매개변수, btn 내부 매개변수
    func buttonUISetting(buttonOutletName btn: UIButton, buttonTitle title : String = "사탕") {
        // 함수 내부에서는 간단한 이름으로 사용이 가능하다
        // 또한 외부에서 사용하는 매개변수 이름이 생략 할 수 있다면 _를 사용하면 된다.(내부에서는 생략하지 않고 외부에서만 생략하기)
        // _ -> 와일드카드 식별자
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .white
       
    }

    // did end on exit
    @IBAction func keyboardReturnKeyClicked(_ sender: UITextField) {
        // 키보드 내리기
        view.endEditing(true)
        
    }
    
    @IBAction func foodTagButtonClicked(_ sender: UIButton) {
//        print("사탕 버튼 클릭")
//        userSearchTextField.text = "\(Int.random(in: 1...100))"
        
        // title 은 nil이 될 수도 있음
        userSearchTextField.text = sender.currentTitle
    }

}

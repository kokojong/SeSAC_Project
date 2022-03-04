//
//  ViewController.swift
//  SeSAC_week23_Test
//
//  Created by kokojong on 2022/02/28.
//

import UIKit

protocol TextFieldCountDelegate {
    func calculateTextFieldCount(_ text: String) -> Int
}

class ViewController: UIViewController {

    @IBOutlet weak var firstTextField: UITextField!
    
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var result_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        firstTextField.accessibilityIdentifier = "firstTextField"
    }

    func calculateTextFieldCount() -> Int {
        return firstTextField.text?.count ?? 0
    }
    
    @IBAction func firstClicked(_ sender: UIButton) {
        result_label.text = firstTextField.text
    }
}


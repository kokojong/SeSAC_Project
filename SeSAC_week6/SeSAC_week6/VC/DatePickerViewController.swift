//
//  DatePickerViewController.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/05.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var mainDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        mainDatePicker.preferredDatePickerStyle = .wheels
    }
    

   

}

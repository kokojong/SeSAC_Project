//
//  ViewController.swift
//  DDay_assignment
//
//  Created by kokojong on 2021/10/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label100: UILabel!
    @IBOutlet weak var label200: UILabel!
    @IBOutlet weak var label300: UILabel!
    @IBOutlet weak var label400: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDates(date: datePicker.date)
        
        if #available(iOS 14.0, *){
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.preferredDatePickerStyle = .wheels
        }
        

        
    }

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDates(date: sender.date)
        
    }
    
    fileprivate func updateDates(date : Date){
        let format = DateFormatter()
        format.dateFormat = "yyyy년\nMM월 dd일" // 2021년 05월 03일
//        let value = format.string(from: sender.date)
        label100.text = format.string(from: Date(timeInterval: 86400 * 100, since: date))
        label200.text = format.string(from: Date(timeInterval: 86400 * 200, since: date))
        label300.text = format.string(from: Date(timeInterval: 86400 * 300, since: date))
        label400.text = format.string(from: Date(timeInterval: 86400 * 400, since: date))

    }
    
}


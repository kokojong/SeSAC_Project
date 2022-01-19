//
//  DDayViewController.swift
//  SSAC_EmotionDiary
//
//  Created by kokojong on 2021/10/07.
//

import UIKit

class DDayViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 14.0, *){
        datePicker.preferredDatePickerStyle = .inline
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    

    @IBAction func datePickervaluechanged(_ sender: UIDatePicker) {
        
        print(datePicker.date)
        print(sender.date)
        // 영국 표준시간이라서 9시간 차이가 난다
        
        // DataFormatter : 1. DateFormat 2. 한국 시간에 맞추기
        let format = DateFormatter()
        format.dateFormat = "yy/MM/dd" // 21/10/07
        
        let value = format.string(from: sender.date)
        print(value)
        
        // 100일뒤 : TimeInterval 하루는 86400초 (초단위로 interval을 구한다)
        let aftertDate = Date(timeInterval: 86400 * 100, since: sender.date)
        print(aftertDate)
        
    }
    

}

//
//  BoxOfficeDetailViewController.swift
//  SeSAC_week3_MyDiary
//
//  Created by kokojong on 2021/10/15.
//

import UIKit

class BoxOfficeDetailViewController: UIViewController , UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let pickerList : [String] = ["감자","고구마","딸끼","ㅁ","ㄴ"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        titleTextField.text = pickerList[row]
    }
    

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var overviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // textField InputView 써보기
//        titleTextField.inputView = UIDatePicker() // 아래에 뺴꼼ㅋㅋㅋ
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let datePicker = UIPickerView()
        
        titleTextField.inputView = pickerView
        
        
        overviewTextView.delegate = self
        
        // 텍스트뷰 플레이스 홀더 : 글자, 글자색
        overviewTextView.text = "줄거리를 남겨 보시지요"
        overviewTextView.textColor = .lightGray
        
        // Do any additional setup after loading the view.
    }
    
    // 커서 시작
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
        
    }
    
    // 커서 끝
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.text = "줄거리를 남겨보세요"
            textView.textColor = .lightGray
        }
        
    }
    

    

}

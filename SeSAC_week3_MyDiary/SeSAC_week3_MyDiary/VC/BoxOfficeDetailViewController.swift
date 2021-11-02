//
//  BoxOfficeDetailViewController.swift
//  SeSAC_week3_MyDiary
//
//  Created by kokojong on 2021/10/15.
//

import UIKit

class BoxOfficeDetailViewController: UIViewController , UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let pickerList : [String] = ["감자","고구마","딸끼","ㅁ","ㄴ"]
    
    // 전달받을 데이터가 여러개
    // pass data 1. 받을 공간을 할당
//    var movieTitle : String?
//    var releaseDate : String?
//    var runtime : Int?
//    var overview : String?
//    var rate : Double?
    
    // 구조체로 한방에 받기
    var movieData : Movie?
    
    
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
        
        // pass data 2.
//        titleTextField.text = movieTitle
//        overviewTextView.text = overview
//        print(runtime, releaseDate, rate)
        
        titleTextField.text = movieData?.title
        overviewTextView.text = movieData?.overview
        print(movieData?.runtime, movieData?.rate, movieData?.releaseDate)
        
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let datePicker = UIPickerView()
        
        titleTextField.inputView = pickerView
        
        
        overviewTextView.delegate = self
        
        // 텍스트뷰 플레이스 홀더 : 글자, 글자색
//        overviewTextView.text = "줄거리를 남겨 보시지요"
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

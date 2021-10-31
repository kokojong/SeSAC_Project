//
//  LotteryViewController.swift
//  Sesac_week5_Lottery
//
//  Created by kokojong on 2021/10/25.
//

import UIKit
import SwiftyJSON
import Alamofire

class LotteryViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultMainLabel: UILabel!
    @IBOutlet weak var mainPickerView: UIPickerView!
    
    @IBOutlet weak var drwDateLabel: UILabel!
    @IBOutlet weak var result1Label: UILabel!
    @IBOutlet weak var result2Label: UILabel!
    @IBOutlet weak var result3Label: UILabel!
    
    @IBOutlet weak var result4Label: UILabel!
    @IBOutlet weak var result5Label: UILabel!
    @IBOutlet weak var result6Label: UILabel!
    @IBOutlet weak var resultBonusLabel: UILabel!
    
    let numberList: [Int] = Array(1...986).reversed()
    
    var savedArray: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPickerView.delegate = self
        searchTextField.inputView = mainPickerView
        searchTextField.text = "\(numberList[0])"
        getLotteryInfo(drwNo: searchTextField.text!)
        
        setLabelUI(label: result1Label)
        setLabelUI(label: result2Label)
        setLabelUI(label: result3Label)
        setLabelUI(label: result4Label)
        setLabelUI(label: result5Label)
        setLabelUI(label: result6Label)
        setLabelUI(label: resultBonusLabel)
        
    }
    
    func getLotteryInfo(drwNo: String) {
        
        if checkDrwNo(drwNo: drwNo){
            // 이미 저장된 값이면
            print("savedArray: \(savedArray)")
            
            self.result1Label.text = "\(savedArray[0])"
            self.result2Label.text = "\(savedArray[1])"
            self.result3Label.text = "\(savedArray[2])"
            self.result4Label.text = "\(savedArray[3])"
            self.result5Label.text = "\(savedArray[4])"
            self.result6Label.text = "\(savedArray[5])"
            self.resultBonusLabel.text = "\(savedArray[6])"
            self.drwDateLabel.text = "\(savedArray[7]) 추첨"
            
            
        } else {
            // 저장된 값이 아니라면(새로 불러온다면)
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)"
            
                // https://www.dhlottery.co.kr/common.do? method=getLottoNumber&drwNo=903
                
                AF.request(url, method: .get).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                       
                        let drwtNo1 = json["drwtNo1"].intValue
                        let drwtNo2 = json["drwtNo2"].intValue
                        let drwtNo3 = json["drwtNo3"].intValue
                        let drwtNo4 = json["drwtNo4"].intValue
                        let drwtNo5 = json["drwtNo5"].intValue
                        let drwtNo6 = json["drwtNo6"].intValue
                        let bnusNo = json["bnusNo"].intValue
                        
                        let date = json["drwNoDate"].stringValue
                        let drwtNumbers: [Any] = [drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6, bnusNo, date]
                        UserDefaults.standard.set(drwtNumbers, forKey: drwNo)
                        print(drwtNumbers)
                        self.drwDateLabel.text = "\(date) 추첨"
                        
                        self.result1Label.text = "\(drwtNo1)"
                        self.result2Label.text = "\(drwtNo2)"
                        self.result3Label.text = "\(drwtNo3)"
                        self.result4Label.text = "\(drwtNo4)"
                        self.result5Label.text = "\(drwtNo5)"
                        self.result6Label.text = "\(drwtNo6)"
                        
                        self.resultBonusLabel.text = "\(bnusNo)"
                        
                        
                    case .failure(let error):
                        print(error)
                }
            }
            
            
        }
        
            
        
        
    }
    
    func checkDrwNo(drwNo: String) -> Bool {
        if let result = UserDefaults.standard.array(forKey: drwNo) {
            self.savedArray = result
            return true
        } else {
            return false
        }
        

    }
    
    func setLabelUI(label: UILabel) {
        label.clipsToBounds = true
        label.layer.cornerRadius = label.bounds.width / 2
        
    }
    
    @IBAction func mainTextFieldDidEnd(_ sender: UITextField) {
        let search = sender.text
        getLotteryInfo(drwNo: search!)
        
    }
    
    
    

}

extension LotteryViewController: UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        searchTextField.text = "\(numberList[row])"
        getLotteryInfo(drwNo: searchTextField.text!)
    }
    

}



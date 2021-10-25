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
    
    let numberList: [Int] = Array(1...986).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPickerView.delegate = self
        searchTextField.inputView = mainPickerView
        searchTextField.text = "\(numberList[0])"
        getLotteryInfo(drwNo: searchTextField.text!)
        
    }
    
    func getLotteryInfo(drwNo: String) {
            
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)"
        
            // https://www.dhlottery.co.kr/common.do? method=getLottoNumber&drwNo=903
            
            AF.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }

        
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



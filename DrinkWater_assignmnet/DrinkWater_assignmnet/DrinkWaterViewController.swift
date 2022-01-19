//
//  DrinkWaterViewController.swift
//  DrinkWater_assignmnet
//
//  Created by kokojong on 2021/10/08.
//

import UIKit

class DrinkWaterViewController: UIViewController {
    
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var profileButton: UIBarButtonItem!
  
    @IBOutlet weak var text1Label: UILabel!
    @IBOutlet weak var todaymlLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var mlLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var drinkWaterButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        
        // 임시로 넣은 값
//        UserDefaults.standard.set(2100, forKey: "totalDrink")
        
        setResetButton()
        setProfileButton()
        setText1Label()
        setTodaymlLabel()
        setPercentageLabel()
        
        setMainImageView()
        setMainTextField()
        setmlLabel()
        setSummaryLabel()
        setDrinkWaterButton()
        
        updateSummaryLabel() // 먼저 한 이유: total의 값이 0일때 2100으로 디폴트 값을 넣어줌(divide by 0 error 차단)
        updateTodaymlLabel()
        updatePercentageLabel()
        updateMainImageView()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        updateSummaryLabel()
        updateTodaymlLabel()
        updatePercentageLabel()
        updateMainImageView()
    }
    
    fileprivate func setResetButton(){
        resetButton.tintColor = .white
    }
    
    fileprivate func setProfileButton(){
        profileButton.tintColor = .white
    }
    
    fileprivate func setText1Label(){
        text1Label.textColor = .white
    }
    
    fileprivate func setTodaymlLabel(){
        updateTodaymlLabel()
        todaymlLabel.textColor = .white
        todaymlLabel.font = .boldSystemFont(ofSize: 35)
    }
    
    fileprivate func setPercentageLabel(){
        updatePercentageLabel()
        percentageLabel.textColor = .white
        percentageLabel.font = .systemFont(ofSize: 13)
        
    }
    
    fileprivate func setMainImageView(){
        
    }
    
    fileprivate func setMainTextField(){
        mainTextField.placeholder = "물의 양"
        mainTextField.keyboardType = .numberPad
        mainTextField.borderStyle = .none
        mainTextField.backgroundColor = .systemGreen
        mainTextField.textColor = .white
        mainTextField.textAlignment = .right
        mainTextField.font = .boldSystemFont(ofSize: 30)
        
    }
    
    fileprivate func setSummaryLabel(){
        summaryLabel.font = .systemFont(ofSize: 13)
        summaryLabel.textColor = .white
    }
    
    fileprivate func setmlLabel(){
        mlLabel.text = "ml"
        mlLabel.textColor = .white
        mlLabel.font = .systemFont(ofSize: 17)
        mlLabel.backgroundColor = .systemGreen
    }
    fileprivate func setDrinkWaterButton(){
        drinkWaterButton.backgroundColor = .white
        drinkWaterButton.setTitle("물 마시기", for: .normal)
        drinkWaterButton.setTitleColor(.black, for: .normal)
    }
    
    fileprivate func updateTodaymlLabel(){
        todaymlLabel.text = "\(UserDefaults.standard.integer(forKey: "todayDrink"))ml"
    }
    
    fileprivate func updatePercentageLabel(){
        let total = UserDefaults.standard.integer(forKey: "totalDrink")
        let today = UserDefaults.standard.integer(forKey: "todayDrink")
        let percentage = today * 100 / total
        UserDefaults.standard.set(percentage, forKey: "percentage")
        
        percentageLabel.text = "목표의 \(UserDefaults.standard.integer(forKey: "percentage"))%"
        
        if percentage >= 100 {
            todaymlLabel.textColor = .systemRed
        } else{
            todaymlLabel.textColor = .white
        }
        
    }
    
    fileprivate func updateMainImageView(){
        let percentage = UserDefaults.standard.integer(forKey: "percentage")
        
        switch percentage{
        case 0...9: mainImageView.image = UIImage(named: "1-1")
        case 10...19:mainImageView.image = UIImage(named: "1-2")
        case 20...29:mainImageView.image = UIImage(named: "1-3")
        case 30...39:mainImageView.image = UIImage(named: "1-4")
        case 40...49:mainImageView.image = UIImage(named: "1-5")
        case 50...59:mainImageView.image = UIImage(named: "1-6")
        case 60...69:mainImageView.image = UIImage(named: "1-7")
        case 70...79:mainImageView.image = UIImage(named: "1-8")
        default :mainImageView.image = UIImage(named: "1-9")
        }
        
    }
    
    fileprivate func updateSummaryLabel(){
        
        let name : String = UserDefaults.standard.string(forKey: "name") ?? "익명"
        var totalDrink = UserDefaults.standard.integer(forKey: "totalDrink")
        if totalDrink == 0 {
            totalDrink = 2100 // 기본값
        }
        let totalDrinkL : Double =  Double(totalDrink) / 1000
        
        summaryLabel.text = "\(name)님의 하루 물 권장 섭취량은 \(totalDrinkL)L입니다."
    }
    
    
    @IBAction func onTapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func onResetButtonClicked(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(0, forKey: "todayDrink")
        updateTodaymlLabel()
        updatePercentageLabel()
        updateMainImageView()
        updateSummaryLabel()
    }
    
    @IBAction func onDrinkButtonClicked(_ sender: UIButton) {
        let nowDrink : Int = Int(mainTextField.text!) ?? 0
        let todayDrink = UserDefaults.standard.integer(forKey: "todayDrink")
        UserDefaults.standard.set(todayDrink + nowDrink, forKey:"todayDrink")
        mainTextField.text = "" // 초기화
        updateTodaymlLabel()
        updatePercentageLabel()
        updateMainImageView()
        updateSummaryLabel()
    }
    
}

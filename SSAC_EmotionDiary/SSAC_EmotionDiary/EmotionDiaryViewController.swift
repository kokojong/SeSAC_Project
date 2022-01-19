//
//  EmotionDiaryViewController.swift
//  SSAC_EmotionDiary
//
//  Created by kokojong on 2021/10/06.
//

import UIKit

class EmotionDiaryViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    @IBOutlet weak var label9: UILabel!
    
    var counts = [Int](repeating: 0, count: 10)
    var labelTitles = [String](repeating: "", count: 10)

    override func viewDidLoad() {
          super.viewDidLoad()
        setButtonTag()
        setLabelTag()
        getLabelTitles()
        setLabelTitles()
//        objc func로 해본 경우
//        button1.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
//        button2.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
//        button3.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
        
//        loadUserDefaults()

        
    }
    
    fileprivate func setButtonTag(){
        button1.tag = 1
        button2.tag = 2
        button3.tag = 3
        button4.tag = 4
        button5.tag = 5
        button6.tag = 6
        button7.tag = 7
        button8.tag = 8
        button9.tag = 9
    }
    

    fileprivate func setLabelTag(){
        label1.tag = 1
        label2.tag = 2
        label3.tag = 3
        label4.tag = 4
        label5.tag = 5
        label6.tag = 6
        label7.tag = 7
        label8.tag = 8
        label9.tag = 9
        
    }
    
    fileprivate func getLabelTitles(){
        labelTitles[1] = label1.text ?? ""
        labelTitles[2] = label2.text ?? ""
        labelTitles[3] = label3.text ?? ""
        labelTitles[4] = label4.text ?? ""
        labelTitles[5] = label5.text ?? ""
        labelTitles[6] = label6.text ?? ""
        labelTitles[7] = label7.text ?? ""
        labelTitles[8] = label8.text ?? ""
        labelTitles[9] = label9.text ?? ""
        
    }
    
    fileprivate func setLabelTitles(){
        label1.text = label1.text! + " \(counts[1])"
        label2.text = label2.text! + " \(counts[2])"
        label3.text = label3.text! + " \(counts[3])"
        label4.text = label4.text! + " \(counts[4])"
        label5.text = label5.text! + " \(counts[5])"
        label6.text = label6.text! + " \(counts[6])"
        label7.text = label7.text! + " \(counts[7])"
        label8.text = label8.text! + " \(counts[8])"
        label9.text = label9.text! + " \(counts[9])"
        
    }
    
    @objc fileprivate func onClickButton(_ btn : UIButton){
//        btn.tag
    }
    
    @IBAction func onButtonClicked(_ sender: UIButton) {
//        print(sender.tag)
        switch sender.tag{
        case 1:
            updateCounts(num: 1, label: label1)
        case 2:
            updateCounts(num: 2, label: label2)
        case 3:
            updateCounts(num: 3, label: label3)
        case 4:
            updateCounts(num: 4, label: label4)
        case 5:
            updateCounts(num: 5, label: label5)
        case 6:
            updateCounts(num: 6, label: label6)
        case 7:
            updateCounts(num: 7, label: label7)
        case 8:
            updateCounts(num: 8, label: label8)
        case 9:
            updateCounts(num: 9, label: label9)
        default:
            print("default")
        }
        
//        switch sender.tag {
//        case 1 :
//            updateCounts(num: 1, label: label1)
////            counts[1] += 1
////            UserDefaults.standard.set(counts[1], forKey: "\(label1.tag)")
////
////            label1.text = "\(labelTitles[1]) \(UserDefaults.standard.integer(forKey: "\(label1.tag)"))"

    }
    
    fileprivate func updateCounts(num:Int, label:UILabel){
        counts[num] += 1
        UserDefaults.standard.set(counts[num], forKey: "\(label.tag)")
        
        label.text = "\(labelTitles[num]) \(UserDefaults.standard.integer(forKey: "\(label.tag)"))"
        
    }
    
}

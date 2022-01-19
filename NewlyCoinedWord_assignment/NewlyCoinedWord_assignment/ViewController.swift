//
//  ViewController.swift
//  NewlyCoinedWord_assignment
//
//  Created by kokojong on 2021/10/01.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var firstTagButton: UIButton!
    @IBOutlet weak var secondTagButton: UIButton!
    @IBOutlet weak var thirdTagButton: UIButton!
    @IBOutlet weak var fourthTagButton: UIButton!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    let wordList : Array<String> = ["스드메","꾸안꾸","만반잘부","삼귀자","머선129","뇌피셜","잼민이"]
    let wordMeaningList : Array<String> = ["스튜디오 드레스 메이크업", "스튜디오 드레스 메이크업의 줄임말","만나서 반가워요 잘부탁해요의 줄임말","사귀기전의 썸 단계","무슨 일이고?의 줄임말","뇌+오피셜의 합성어로 제대로 된 정보가 아님","어린 학생을 낮춰서 부르는 말"]
    let numList = Array<Int>(0...6)
    var wordDictionary : [String : String] = ["스드메":"스튜디오 드레스 메이크업의 줄임말","꾸안꾸":"꾸민듯 안꾸민듯 꾸밈의 줄임말","만반잘부":"만나서 반가워요 잘부탁해요의 줄임말","삼귀자":"사귀기전의 썸 단계","머선129" :"무슨 일이고?의 줄임말","뇌피셜":"뇌+오피셜의 합성어로 제대로 된 정보가 아님을 뜻함","잼민이":"나이가 어린 학생을 낮춰서 부르는 말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopStackView()
        searchTextField.placeholder = "검색어를 입력해주세요"
        mainLabel.adjustsFontSizeToFitWidth = true
        mainLabel.minimumScaleFactor = 0.001
        
        setRandomTagbutton()
        setTagButton(btn: firstTagButton)
        setTagButton(btn: secondTagButton)
        setTagButton(btn: thirdTagButton)
        setTagButton(btn: fourthTagButton)
        
    }
    
    fileprivate func setTopStackView(){
        topStackView.layer.borderWidth = 2
        topStackView.layer.borderColor = UIColor.black.cgColor
        
    }
    
    fileprivate func setTagButton(btn : UIButton){
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.setTitleColor(.black, for: .normal)
      
        
    }
    
    fileprivate func checkWordAndChangeLabel(word: String){
        if word.isEmpty{
//            mainLabel.text = "검색어를 입력하거나 추천단어를 눌러보세요"
            showAlertPopUp(title: "검색어를 입력하거나 추천단어를 눌러보세요", button: "확인")
        }
        else if wordDictionary.keys.contains(word){
            mainLabel.text = wordDictionary[word]
        } else {
//            mainLabel.text = "이 단어는 잘 모르겠어요.. 제가 늙은이라..."
            showAlertPopUp(title: "이 단어는 잘 모르겠어요.. 제가 늙은이라...", button: "미안...")
        }
        
    }
    
    fileprivate func setRandomTagbutton(){
        let nums = numList.shuffled()
        firstTagButton.setTitle(wordList[nums[0]], for: .normal)
        secondTagButton.setTitle(wordList[nums[1]], for: .normal)
        thirdTagButton.setTitle(wordList[nums[2]], for: .normal)
        fourthTagButton.setTitle(wordList[nums[3]], for: .normal)
    }
    
    fileprivate func showAlertPopUp(title:String,button:String){
        // 경고창의 내용. message는 공란으로 처리했다
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        // 확인버튼 만들기
        let btn = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(btn)
        present(alert, animated: true, completion: nil)
        
    }

    // did end on exit (return)
    @IBAction func onSearchTextFieldReturn(_ sender: UITextField) {
        view.endEditing(true)
//        onSearchButtonClicked(searchButton)
    }

    
    @IBAction func onSearchButtonClicked(_ sender: UIButton) {
        let word : String! = searchTextField.text
        checkWordAndChangeLabel(word: word )
        setRandomTagbutton()
    }
    
    
    @IBAction func onTagButtonClicked(_ sender: UIButton) {
        let word : String! = sender.currentTitle
        checkWordAndChangeLabel(word: word)
        setRandomTagbutton()
    }
    
    @IBAction func onTapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}


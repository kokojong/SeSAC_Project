//
//  RandomViewController.swift
//  SSAC_Food
//
//  Created by kokojong on 2021/09/29.
//

import UIKit

class RandomViewController: UIViewController {
    
    
    @IBOutlet weak var randomLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    // 뷰컨트롤러 생명주기
    // 화면이 사용자에게 보여지기 직전에 실행되는 기능 : 모서리를 둥글게, 그림자 속성 등
    // 스토리보드에서 구현하기에는 까다로운 UI를 미리 구현할 때 주로 사용
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomLabel.text = "안녕하세요\n반가워요"
        randomLabel.textAlignment = .center
        randomLabel.backgroundColor = .systemRed
        randomLabel.numberOfLines = 2
        randomLabel.font = UIFont.boldSystemFont(ofSize: 20)
        randomLabel.textColor = UIColor.white
        randomLabel.layer.cornerRadius = 10
        randomLabel.clipsToBounds = true
        
        checkButton.backgroundColor = UIColor.green
        checkButton.setTitle("행운의 숫자를 뽑아보세요", for: .normal)
        checkButton.setTitle("뽀바뽀바", for: .highlighted)
        checkButton.layer.cornerRadius = 10
        checkButton.setTitleColor(UIColor.white, for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        let number = Int.random(in: 1...100)
        randomLabel.text = "행운의 숫자는 \(number) 입니다."
        print("hihi")
        
    }

  

}

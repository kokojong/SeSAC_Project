//
//  PopupViewController.swift
//  SeSAC_week7_Memo_assignment
//
//  Created by kokojong on 2021/11/08.
//

import UIKit

class PopupViewController: UIViewController {
    
    static let identifier = "PopupViewController"
    @IBOutlet weak var popupContainer: UIView!
    @IBOutlet weak var popupLabel1: UILabel!
    @IBOutlet weak var popupLabel2: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupContainer.layer.cornerRadius = 5
        popupContainer.backgroundColor = .lightGray
        
        popupLabel1.text = "처음 오셨군요!\n환영합니다"
        popupLabel1.font = .systemFont(ofSize: 15)
        
        
        popupLabel2.text = "당신만의 메모를 작성하고\n관리해보세요"
        popupLabel2.font = .systemFont(ofSize: 15)
        
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.backgroundColor = .systemOrange
        confirmButton.setTitleColor(.white, for: .normal)
    

       
    }
    

    @IBAction func onConfirmButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

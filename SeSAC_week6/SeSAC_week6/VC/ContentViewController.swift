//
//  ContentViewController.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import UIKit
import RealmSwift

class ContentViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "content"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action:#selector(closeButtonClicked) )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked) )
        
        print("Realm:",localRealm.configuration.fileURL!)
    }
    
    @objc func closeButtonClicked() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func saveButtonClicked() {
        
        print("saved")
        
        let task = UserDiary(diaryTitle: titleTextField.text! , diaryContent: contentTextView.text!, diaryDate: Date(), diaryRegisterDate: Date())
        try! localRealm.write {
            localRealm.add(task)
        }
        
        
    }
    
}

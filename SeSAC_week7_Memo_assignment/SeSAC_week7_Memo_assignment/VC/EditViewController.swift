//
//  EditViewController.swift
//  SeSAC_week7_Memo_assignment
//
//  Created by kokojong on 2021/11/09.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {
    
    static let identifier = "EditViewController"
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    @IBOutlet weak var confirmBarButton: UIBarButtonItem!
    @IBOutlet weak var memoTextView: UITextView!
    
    var isTitle = true
    var memoTitle = ""
    var memoContent = ""
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareBarButton.tintColor = .systemOrange
        shareBarButton.title = ""

        confirmBarButton.tintColor = .systemOrange
        confirmBarButton.title = "완료"
       
        memoTextView.becomeFirstResponder()
        memoTextView.delegate = self
        
    }
    
    @objc func onBackBarItemClicked(){
        print("onBackBarItemClicked")
    }
    
    @IBAction func onShareBarButtonClicked(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func onConfirmBarButtonClicked(_ sender: UIBarButtonItem) {
        
//        let splitTextList: [String] = memoTextView.text.components(separatedBy: "\n")
//
//        memoTitle = splitTextList.first ?? "메모 없음"
//
//        if splitTextList.count >= 2 {
//            for i in (1...splitTextList.count - 1){
//                if i == 1 {
//                    memoContent += splitTextList[i]
//                } else {
//                    memoContent += "\n" + splitTextList[i]
//                }
//            }
//
//        }
//        print("memoTitle: ",memoTitle)
//        print("memoContent: ",memoContent)
        
        
        let splitTextList2 = memoTextView.text.split(separator: "\n", maxSplits: 1, omittingEmptySubsequences: true)
        
//        아예 비어있거나, content가 없는 경우에 대한 분기처리
        if memoTextView.text.isEmpty { // 아무것도 안쓴 경우 -> 삭제
            print(0)
            navigationController?.popViewController(animated: true)
            return
            
        } else if splitTextList2.count == 1 { // 제목만 있는 경우
            memoTitle = String(splitTextList2[0])
            
        } else {
            memoTitle = String(splitTextList2[0])
            memoContent = String(splitTextList2[1])
            print("splitTextList2[0] :", splitTextList2[0])
            print("splitTextList2[1] :", splitTextList2[1])
        }
        
        let task = Memo(memoTitle: memoTitle, memoContent: memoContent, memoDate: Date())
        
        try! localRealm.write {
            localRealm.add(task)
        }
        
        
    }
}

extension EditViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" && isTitle{
            print("return")
            isTitle = false
        }
        return true
    }
    
}

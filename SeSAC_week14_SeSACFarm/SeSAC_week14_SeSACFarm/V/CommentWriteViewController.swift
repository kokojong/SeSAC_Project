//
//  WriteCommentViewController.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/05.
//

import UIKit

class CommentWriteViewController: UIViewController {
    
    var viewModel = CommentWriteViewModel()
    var postId = 0

    let commentTextView : UITextView = {
       let textView = UITextView()
        textView.layer.cornerRadius = 8
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(commentTextView)
        commentTextView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonClicked))]
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelButtonClicked))]
        
    }
    
    @objc func onDoneButtonClicked() {
        print("done")
        viewModel.writeNewComment(comment: commentTextView.text, postId: postId) {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    @objc func onCancelButtonClicked() {
        print("cancel")
        self.navigationController?.popViewController(animated: true)
    }
    
}

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

    var isUpdate = false
    
    let commentTextView : UITextView = {
       let textView = UITextView()
        textView.layer.cornerRadius = 8
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        
        return textView
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isUpdate {
            title = "댓글수정"
        } else {
            title = "댓글작성"
        }
        
        view.backgroundColor = .white
        
        view.addSubview(commentTextView)
        commentTextView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(commentTextView.snp.width).multipliedBy(0.66)
        }
        
        viewModel.comment.bind { comment in
            self.commentTextView.text = comment.comment
        }
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonClicked))]
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelButtonClicked))]
        
    }
    
    @objc func onDoneButtonClicked() {
        print("댓글 수정 버튼")
        if isUpdate {
            print("postId",viewModel.comment.value.post.id)
            print("viewModel.comment.value.id",viewModel.comment.value.id)
            viewModel.updateComment(comment: commentTextView.text, postId: viewModel.comment.value.post.id, commentId: viewModel.comment.value.id) {
                print("댓글 수정 완료")
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            viewModel.writeNewComment(comment: commentTextView.text, postId: postId) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
        
    }
    @objc func onCancelButtonClicked() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

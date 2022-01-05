//
//  PostWriteViewController.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/04.
//

import UIKit

class PostWriteViewController: UIViewController {
    
    let postWriteView = PostWriteView()
    var viewModel = PostWriteViewModel()
    
    var isUpdate = false
    
    override func loadView() {
        self.view = postWriteView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonClicked))]
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelButtonClicked))]
        
        viewModel.writtenPost.bind { postElement in
            self.postWriteView.textView.text = postElement.text
        }
     
    }
    
    @objc func onDoneButtonClicked() {
        print("done")
        if isUpdate {
            viewModel.updatePost(postId: viewModel.writtenPost.value.id, text: postWriteView.textView.text) {
                print("update")
                self.navigationController?.popViewController(animated: true)
                
            }
        } else {
            viewModel.writeNewPost(text: postWriteView.textView.text) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    @objc func onCancelButtonClicked() {
        print("cancel")
        self.navigationController?.popViewController(animated: true)
    }
    
}

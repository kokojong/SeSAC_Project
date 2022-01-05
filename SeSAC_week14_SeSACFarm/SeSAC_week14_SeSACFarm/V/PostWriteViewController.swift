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
    
    override func loadView() {
        self.view = postWriteView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonClicked))]
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelButtonClicked))]
     
    }
    
    @objc func onDoneButtonClicked() {
        print("done")
        viewModel.writeNewPost(text: postWriteView.textView.text) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @objc func onCancelButtonClicked() {
        print("cancel")
        self.navigationController?.popViewController(animated: true)
    }
    
}

//
//  PostDetailViewController.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/04.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    let postDetailView = PostDetailView()
    var viewModel = PostDetailViewModel()
    
    override func loadView() {
        self.view = postDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        postDetailView.nickNameLabel.text = viewModel.detailPost.value.user.username
        postDetailView.createdDateLabel.text = viewModel.detailPost.value.createdAt
        postDetailView.contentLabel.text = viewModel.detailPost.value.text
        postDetailView.goToCommentLabel.text = "댓글  \(viewModel.detailPost.value.comments.count)개"
//        postDetailView.
    }
    


}

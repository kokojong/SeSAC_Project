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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.fetchOnePost(id: viewModel.detailPost.value.id) {
            self.postDetailView.contentLabel.text = self.viewModel.detailPost.value.text
        }
        viewModel.fetchComment(id: viewModel.detailPost.value.id) {
            
        }
        viewModel.postId.bind { id in
            
        }

        viewModel.comments.bind { comment in
            self.postDetailView.goToCommentLabel.text = "댓글  \(comment.count)개"
            
            self.postDetailView.commentsTableView.reloadData()
           
        }
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        viewModel.fetchOnePost(id: viewModel.postId.value) {

        }
        
        viewModel.fetchComment(id: viewModel.postId.value) {
          
        }

      
        viewModel.postId.bind { id in

        }
        
        viewModel.comments.bind { comment in
            self.postDetailView.commentsTableView.reloadData()
            
        }
      
        print(viewModel.postId.value)
        print(viewModel.detailPost.value.id)
        
        postDetailView.nicknameLabel.text = viewModel.detailPost.value.user.username
        postDetailView.createdDateLabel.text = viewModel.detailPost.value.createdAt
        postDetailView.contentLabel.text = viewModel.detailPost.value.text
        postDetailView.goToCommentLabel.text = "댓글  \(viewModel.detailPost.value.comments.count)개"
//        postDetailView.
        let isMyPost = viewModel.detailPost.value.user.id == UserDefaults.standard.integer(forKey: "userId")
        postDetailView.optionButton.isHidden = !isMyPost
        postDetailView.optionButton.addTarget(self, action: #selector(onOptionButtonClicked), for: .touchUpInside)
            
        
       
        
        postDetailView.commentsTableView.delegate = self
        postDetailView.commentsTableView.dataSource = self
        postDetailView.commentsTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        postDetailView.commentsTableView.rowHeight = UITableView.automaticDimension
        
        postDetailView.writeCommentButton.addTarget(self, action: #selector(onWriteCommentButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func onWriteCommentButtonClicked() {
        print(#function)
        
        let vc = CommentWriteViewController()
        vc.postId = viewModel.detailPost.value.id
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onOptionButtonClicked() {
        let alert = UIAlertController(title: "수정/삭제", message: "게시글을 수정/삭제 하시겠습니까?", preferredStyle: .alert)
        
        let update = UIAlertAction(title: "수정", style: .default) { action in
            // 값을 넘겨줌
            let vc = PostWriteViewController()
            vc.viewModel.writtenPost.value = self.viewModel.detailPost.value
            vc.isUpdate = true
            self.navigationController?.pushViewController(vc, animated: true)
//            self.navigationController?.pushViewController(vc, animated: true, completion: {
                
//            })
        }
        let delete = UIAlertAction(title: "삭제", style: .default) { action in
            self.showDeletePostCheckAlert()
        }
            
        
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        
        // 3. 1과 2를 합쳐준다
        // addAction의 순서대로 버튼이 붙는다
        alert.addAction(update)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        // 4. Present (보여줌) - modal처럼
        present(alert, animated: true, completion: nil)
        
    }
    
    @objc func onCommentOptionButtonClicked(sender: UIButton) {
        let alert = UIAlertController(title: "수정/삭제", message: "댓글을 수정/삭제 하시겠습니까?", preferredStyle: .alert)
        // 2. UIAlertAction 생성 : 버튼들을 만들어준다
        let update = UIAlertAction(title: "수정", style: .default) { action in
            // 값을 넘겨줌
            let vc = CommentWriteViewController()
            vc.isUpdate = true
            
            vc.viewModel.comment.value =  self.viewModel.comments.value[sender.tag]
        
            vc.isUpdate = true
            self.navigationController?.pushViewController(vc, animated: true)

        }
        let delete = UIAlertAction(title: "삭제", style: .default) { action in
            self.viewModel.comment.value = self.viewModel.comments.value[sender.tag]
            self.showDeleteCommentCheckAlert()
        }
            
        
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        
        // 3. 1과 2를 합쳐준다
        // addAction의 순서대로 버튼이 붙는다
        alert.addAction(update)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        // 4. Present (보여줌) - modal처럼
        present(alert, animated: true, completion: nil)
    }
    
    func showDeletePostCheckAlert() {
        
        let alert = UIAlertController(title: "게시글 삭제", message: "정말로 게시글을 삭제하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "삭제하기", style: .default) { alertAction in
            // postDetail vm에서 콜해주기
            self.viewModel.deletePost(id: self.viewModel.detailPost.value.id) {
            }
            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showDeleteCommentCheckAlert() {
        
        let alert = UIAlertController(title: "댓글 삭제", message: "정말로 댓글을 삭제하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "삭제하기", style: .default) { alertAction in
            
            
            self.viewModel.deleteComment(commentId: self.viewModel.comment.value.id) {
                print("delete성공")
                
                self.viewModel.fetchOnePost(id: self.viewModel.detailPost.value.id){
                    
                    
                }
                self.viewModel.fetchComment(id: self.viewModel.detailPost.value.id) {
                    self.postDetailView.commentsTableView.reloadData()
                }
                
                
            }

            self.viewModel.comments.bind { comment in
                self.postDetailView.goToCommentLabel.text = "댓글  \(comment.count)개"
                
                self.postDetailView.commentsTableView.reloadData()
               
            }
            
//            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }


}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        
        let row = viewModel.cellForRowAt(indexPath: indexPath)
        cell.nicknameLabel.text = row.user.username
        cell.contentLabel.text = row.comment
//        cell.nicknameLabel.text = "nickname"
//        cell.contentLabel.text = "content"
        let isMyComment = row.user.id == UserDefaults.standard.integer(forKey: "userId")
        cell.optionButton.isHidden = !isMyComment
        cell.optionButton.addTarget(self, action: #selector(onCommentOptionButtonClicked(sender:)), for: .touchUpInside)
        cell.optionButton.tag = indexPath.row
        
        return cell
    }
    
   
    
}

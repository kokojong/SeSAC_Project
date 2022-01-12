//
//  PostDetailViewController.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/04.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    let postDetailHeaderView = PostDetailHeaderView()
    let postDetailTableView = PostDetailTableView()
    
    var viewModel = PostDetailViewModel()
    
    // tableView라서 스크롤을 해야해서 이게 동작을 안한다 ㅋㅋㅋ ㅜㅜ
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func loadView() {
        self.view = postDetailTableView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.fetchOnePost(id: viewModel.detailPost.value.id) {
            self.postDetailHeaderView.contentLabel.text = self.viewModel.detailPost.value.text
        }
        viewModel.fetchComment(id: viewModel.detailPost.value.id) {
            
        }
        viewModel.postId.bind { id in
            
        }

        viewModel.comments.bind { comment in
            self.postDetailHeaderView.goToCommentLabel.text = "댓글  \(comment.count)개"
            
            self.postDetailTableView.commentsTableView.reloadData()
           
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
            self.postDetailTableView.commentsTableView.reloadData()
            
        }
      
        postDetailHeaderView.nicknameLabel.text = viewModel.detailPost.value.user.username
        postDetailHeaderView.createdDateLabel.text = viewModel.detailPost.value.createdAt.toDate
        postDetailHeaderView.contentLabel.text = viewModel.detailPost.value.text
        postDetailHeaderView.goToCommentLabel.text = "댓글  \(viewModel.detailPost.value.comments.count)개"

        let isMyPost = viewModel.detailPost.value.user.id == UserDefaults.standard.integer(forKey: "userId")
        postDetailHeaderView.optionButton.isHidden = !isMyPost
        postDetailHeaderView.optionButton.addTarget(self, action: #selector(onOptionButtonClicked), for: .touchUpInside)
            
        
        postDetailTableView.commentsTableView.delegate = self
        postDetailTableView.commentsTableView.dataSource = self
        postDetailTableView.commentsTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        postDetailTableView.commentsTableView.rowHeight = UITableView.automaticDimension
        
        postDetailTableView.commentWriteView.writeCommentButton.addTarget(self, action: #selector(onWriteCommentButtonClicked), for: .touchUpInside)
        postDetailTableView.commentWriteView.commentTextField.delegate = self
        textFieldShouldReturn(postDetailTableView.commentWriteView.commentTextField)
        // 키보드 높이만큼 변경
//        addKeyboardNotification()
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false

        postDetailHeaderView.addGestureRecognizer(singleTapGestureRecognizer)



        
        
    }
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        
    }
    
    @objc func onWriteCommentButtonClicked() {

        guard let comment = self.postDetailTableView.commentWriteView.commentTextField.text else { return }
        
        if comment == "" {
            self.view.makeToast("댓글 내용을 작성해주세요")
            return
        }
        
        self.viewModel.writeNewComment(comment: comment, postId: viewModel.postId.value) {
            self.postDetailTableView.commentWriteView.commentTextField.text = ""
            self.viewModel.fetchComment(id: self.viewModel.postId.value) {
                
            }
            
            self.viewModel.comments.bind { comment in
                self.postDetailHeaderView.goToCommentLabel.text = "댓글  \(comment.count)개"
                self.postDetailTableView.commentsTableView.reloadData()
            }
            
        }
        
    }
    
    @objc func onOptionButtonClicked() {
        let alert = UIAlertController(title: "수정/삭제", message: "게시글을 수정/삭제 하시겠습니까?", preferredStyle: .alert)
        
        let update = UIAlertAction(title: "수정", style: .default) { action in
            
            let vc = PostWriteViewController()
            vc.viewModel.writtenPost.value = self.viewModel.detailPost.value
            vc.isUpdate = true
            self.navigationController?.pushViewController(vc, animated: true)

        }
        let delete = UIAlertAction(title: "삭제", style: .destructive) { action in
            self.showDeletePostCheckAlert()
        }
            
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(update)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @objc func onCommentOptionButtonClicked(sender: UIButton) {
        let alert = UIAlertController(title: "수정/삭제", message: "댓글을 수정/삭제 하시겠습니까?", preferredStyle: .alert)
        
        let update = UIAlertAction(title: "수정", style: .default) { action in
            
            let vc = CommentWriteViewController()
            vc.isUpdate = true
            
            vc.viewModel.comment.value =  self.viewModel.comments.value[sender.tag]
        
            vc.isUpdate = true
            self.navigationController?.pushViewController(vc, animated: true)

        }
        let delete = UIAlertAction(title: "삭제", style: .destructive) { action in
            self.viewModel.comment.value = self.viewModel.comments.value[sender.tag]
            self.showDeleteCommentCheckAlert()
        }
            
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(update)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showDeletePostCheckAlert() {
        
        let alert = UIAlertController(title: "게시글 삭제", message: "정말로 게시글을 삭제하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "삭제하기", style: .destructive) { alertAction in
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
        
        let ok = UIAlertAction(title: "삭제하기", style: .destructive) { alertAction in
            
            
            self.viewModel.deleteComment(commentId: self.viewModel.comment.value.id) {
                print("delete성공")
                
                self.viewModel.fetchOnePost(id: self.viewModel.detailPost.value.id){
                    
                    
                }
                self.viewModel.fetchComment(id: self.viewModel.detailPost.value.id) {
                    self.postDetailTableView.commentsTableView.reloadData()
                }
                
                
            }

            self.viewModel.comments.bind { comment in
                self.postDetailHeaderView.goToCommentLabel.text = "댓글  \(comment.count)개"
                
                self.postDetailTableView.commentsTableView.reloadData()
               
            }
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func addKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardDidChangeFrameNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

    }
    
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keybaordRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keybaordRectangle.height
            print("keyboardHeight",keyboardHeight)
            print("frame",postDetailTableView.commentWriteView.frame.origin.y)
            self.postDetailTableView.commentWriteView.frame.origin.y -= keyboardHeight
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keybaordRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keybaordRectangle.height
            print("keyboardHeight",keyboardHeight)
            print("frame",postDetailTableView.commentWriteView.frame.origin.y)
            self.postDetailTableView.commentWriteView.frame.origin.y += keyboardHeight
        }
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
        let isMyComment = row.user.id == UserDefaults.standard.integer(forKey: "userId")
        cell.optionButton.isHidden = !isMyComment
        cell.optionButton.addTarget(self, action: #selector(onCommentOptionButtonClicked(sender:)), for: .touchUpInside)
        cell.optionButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return postDetailHeaderView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
}


extension PostDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

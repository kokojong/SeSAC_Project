//
//  PostDetailViewModel.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/05.
//

import Foundation
import UIKit

class PostDetailViewModel {
    
    var postId: Observable<Int> = Observable(0)
    
    var detailPost: Observable<PostElement> = Observable(PostElement(id: 0, text: "", user: User2(id: 0, username: "", email: "", provider: .local, confirmed: true, blocked: false, role: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: []))
    
    var comment: Observable<CommentElement> = Observable(CommentElement(id: 0, comment: "", user: User3(id: 0, username: "", email: "", provider: .local, confirmed: true, blocked: false, role: 0, createdAt: "", updatedAt: ""), post: PostInfo(id: 0, text: "", user: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: ""))
    
    var comments: Observable<Comments> = Observable(Comments())
    
    func fetchComment(id: Int,completion: @escaping () -> Void){
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.getComment(token: token, postId: id) { post, error in
//            print("post",post)
//            print("error",error)
            checkToken(error: error)
            
            guard let post = post else {
                return
            }
            self.comments.value = post
            completion()
        }
    }
    
    func fetchOnePost(id: Int, completion: @escaping () -> Void){
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.onePost(token: token, postId: id) { post, error in

            checkToken(error: error)
            
            guard let post = post else {
                return
            }
            self.postId.value = id
            self.detailPost.value = post
            completion()
        }
            
        
    }
    
    
    
    func deletePost(id: Int,completion: @escaping () -> Void){
        let token = UserDefaults.standard.string(forKey: "token") ?? ""

        APIService.deletePost(token: token, postId: id) { post, error in
            guard let post = post else {
                return
            }
            
            self.detailPost.value = post
            completion()
        }
    }
    
    func writeNewComment(comment: String, postId: Int, completion: @escaping () -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.writeComment(token: token, comment: comment, PostId: postId) { comment, error in
            
            checkToken(error: error)
            
            print("comment:",comment)
            
            guard let comment = comment else {
                return
            }
            self.comment.value = comment
            
            completion()
        }
        
    }
    
    func updateComment(comment: String, postId: Int, commentId: Int, completion: @escaping () -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.updateComment(token: token, commentId: commentId, postId: postId, comment: comment) { coment, error in
            
            checkToken(error: error)
            
            guard let coment = coment else {
                return
            }

            self.comment.value = coment
            completion()
        }
        
        
    }
    
    func deleteComment(commentId: Int, completion: @escaping () -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.deleteComment(token: token, commentId: commentId) { comment, error in
           
            checkToken(error: error)
            
            guard let comment = comment else {
                return
            }

            self.comment.value = comment
            completion()
        }
        
    }
    
    
}

func checkToken(error: APIError?) {
    print("checkToken")
    if let error = error {
        if error == .unauthorized {
            print("unauthorized")
            UserDefaults.standard.set("", forKey: "token")
            UserDefaults.standard.set(0, forKey: "userId")
            
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }

            
        } else {
            print("error is \(error)")
        }
    }
}

extension PostDetailViewModel {
    var numberOfRowsInSection: Int {
        return comments.value.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> CommentElement {
        return comments.value[indexPath.row]
    }
}

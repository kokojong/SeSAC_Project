//
//  PostDetailViewModel.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/05.
//

import Foundation

class PostDetailViewModel {
    
    var detailPost: Observable<PostElement> = Observable(PostElement(id: 0, text: "", user: User2(id: 0, username: "", email: "", provider: .local, confirmed: true, blocked: false, role: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: []))
    
    
    var comments: Observable<Comments> = Observable(Comments())
    
    func fetchComment(id: Int,completion: @escaping () -> Void){
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.getComment(token: token, postId: id) { post, error in
//            print("post",post)
//            print("error",error)
            guard let post = post else {
                return
            }
            self.comments.value = post
            completion()
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

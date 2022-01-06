//
//  PostUpdateViewModel.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/05.
//

import Foundation

class PostUpdateViewModel {
    
    var updatedPost: Observable<PostElement> = Observable(PostElement(id: 0, text: "", user: User2(id: 0, username: "", email: "", provider: .local, confirmed: false, blocked: false, role: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: []))
    
    func updatePost(postId: Int, text: String, completion: @escaping () -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.updatePost(token: token, postId: postId, text: text) { postElement, error in
            
            checkToken(error: error)
            
            guard let postElement = postElement else {
                return
            }
            self.updatedPost.value = postElement
            
            completion()
        }
        
        
    }
}

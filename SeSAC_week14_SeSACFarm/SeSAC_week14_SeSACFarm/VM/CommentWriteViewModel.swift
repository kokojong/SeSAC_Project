//
//  CommentWriteViewModel.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/05.
//

import Foundation

class CommentWriteViewModel {
    
    var comment: Observable<CommentElement> = Observable(CommentElement(id: 0, comment: "", user: User3(id: 0, username: "", email: "", provider: .local, confirmed: true, blocked: false, role: 0, createdAt: "", updatedAt: ""), post: PostInfo(id: 0, text: "", user: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: ""))
    
    func writeNewComment(comment: String, postId: Int, completion: @escaping () -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.writeComment(token: token, comment: comment, PostId: postId) { comment, error in
            
            guard let comment = comment else {
                return
            }
            self.comment.value = comment
            
            completion()
        }
        
    }
    
    
    
}

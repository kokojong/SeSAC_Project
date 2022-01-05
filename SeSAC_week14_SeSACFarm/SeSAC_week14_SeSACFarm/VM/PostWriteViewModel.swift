//
//  PostWriteViewModel.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/04.
//

import Foundation

class PostWriteViewModel {
    
    var writtenPost: Observable<PostElement> = Observable(PostElement(id: 0, text: "", user: User2(id: 0, username: "", email: "", provider: .local, confirmed: false, blocked: false, role: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: []))
    
    func writeNewPost(text: String, completion: @escaping () -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.writePost(token: token, text: text) { postElement, error in
//            print("postElement : ",postElement)
//            print("error: ",error)
            guard let postElement = postElement else {
                return
            }
            self.writtenPost.value = postElement
            
            completion()
        }
    }
    
    func updatePost(postId: Int, text: String, completion: @escaping () -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.updatePost(token: token, postId: postId, text: text) { postElement, error in
            
            guard let postElement = postElement else {
                return
            }
            self.writtenPost.value = postElement
            
            completion()
        }
        
        
    }
    
    
    
}

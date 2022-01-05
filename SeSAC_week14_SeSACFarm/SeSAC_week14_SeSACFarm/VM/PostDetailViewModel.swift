//
//  PostDetailViewModel.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/05.
//

import Foundation

class PostDetailViewModel {
    
    var detailPost: Observable<PostElement> = Observable(PostElement(id: 0, text: "", user: User2(id: 0, username: "", email: "", provider: .local, confirmed: true, blocked: false, role: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: []))
    
//    func update(post: PostElement) {
//        self.detailPost.value = post
//    }
    
//    var comments:
}

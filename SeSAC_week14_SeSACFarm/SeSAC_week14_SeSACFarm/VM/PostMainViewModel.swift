//
//  PostMainViewModel.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/03.
//

import Foundation

class PostMainViewModel {
    
    var allPosts: Observable<Post> = Observable(Post())
    
    func getAllPosts(completion: @escaping () -> Void){
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.allPosts(token: token) { post, error in
            print("post : ",post)
            print("error: ",error)
            guard let post = post else {
                return
            }
            self.allPosts.value = post
            
            completion()
            
        }
    }
}



extension PostMainViewModel {
    var numberOfItemsInSection: Int {
        return allPosts.value.count
    }
    
    func cellForItemAt(indexPath: IndexPath) -> PostElement {
        return allPosts.value[indexPath.row]
    }
    
}

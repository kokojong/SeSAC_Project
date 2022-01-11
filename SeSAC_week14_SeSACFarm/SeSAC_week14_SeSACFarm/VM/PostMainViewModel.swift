//
//  PostMainViewModel.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/03.
//

import Foundation
import UIKit

class PostMainViewModel {
    
    var allPosts: Observable<Post> = Observable(Post())
    
    var desc: Observable<String> = Observable("desc") // 디폴트를 최신순으로 설정
    
    func getAllPosts(completion: @escaping () -> Void){
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.allPosts(token: token, desc: desc.value) { post, error in
//            print("post : ",post)
//            print("error: ",error)
            
            if let error = error {
                if error == .unauthorized {
                    print("unauthorized")
                    UserDefaults.standard.set("", forKey: "token")
                    UserDefaults.standard.set(0, forKey: "userId")
                    
                    DispatchQueue.main.async {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: SignInViewController())
                        windowScene.windows.first?.makeKeyAndVisible()
                    }

                    
                } else {
                    print("error is \(error)")
                }
            }
            
            guard let post = post else {
                return
            }
            self.allPosts.value = post
            
            completion()
            
        }
    }
}



extension PostMainViewModel {
    var numberOfRowsInSection: Int {
        return allPosts.value.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> PostElement {
        return allPosts.value[indexPath.row]
    }
    
}

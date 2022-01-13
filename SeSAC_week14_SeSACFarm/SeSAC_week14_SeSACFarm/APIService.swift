//
//  APIService.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/02.
//

import Foundation


enum APIError : Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
    case unauthorized
}

class APIService {
    
    static func signUp(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        let url = Endpoint.signUp.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func signIn(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        let url = Endpoint.signIn.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func allPosts(token: String, desc: String, completion: @escaping (Post?, APIError?) -> Void) {
        let url = Endpoint.getPosts(desc: desc).url
        var request = URLRequest(url: url)
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func onePost(token: String, postId: Int, completion: @escaping (PostElement?, APIError?) -> Void) {
        let url = Endpoint.getOnePost(postId: postId).url
        var request = URLRequest(url: url)
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    
    static func writePost(token: String, text: String, completion: @escaping (PostElement?, APIError?) -> Void){
        let url = Endpoint.postPost.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
        
    }
    
    
    static func updatePost(token: String, postId: Int, text: String, completion: @escaping (PostElement?, APIError?) -> Void){
        
        let url = Endpoint.updatePost(postId: postId).url
        var request = URLRequest(url: url)
        request.httpMethod = Method.PUT.rawValue
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.request(endpoint: request, completion: completion)
        
    }
    
    static func deletePost(token: String, postId: Int, completion: @escaping (PostElement?, APIError?) -> Void){
        
        let url = Endpoint.deletePost(postId: postId).url
        var request = URLRequest(url: url)
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
        
    }
    
    static func getComment(token: String, postId: Int, completion: @escaping (Comments?, APIError?) -> Void) {
        let url = Endpoint.getComment(id: postId).url
        var request = URLRequest(url: url)
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
        
    }
    
    static func writeComment(token: String, comment: String, PostId: Int, completion: @escaping (CommentElement?, APIError?) -> Void) {
        let url = Endpoint.getComment(id: PostId).url
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "comment=\(comment)&post=\(PostId)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
        
    }
    
    static func updateComment(token: String, commentId: Int, postId: Int, comment: String, completion: @escaping (CommentElement?, APIError?) -> Void){
        
        let url = Endpoint.updateComment(commentId: commentId).url
        var request = URLRequest(url: url)
        request.httpMethod = Method.PUT.rawValue
//        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        request.httpBody = "comment=\(comment)&post=\(postId)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.request(endpoint: request, completion: completion)
        
    }
    
    static func deleteComment(token: String, commentId: Int, completion: @escaping (CommentElement?, APIError?) -> Void){
        
        let url = Endpoint.deleteComment(commentId: commentId).url
        var request = URLRequest(url: url)
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
        
    }
    
    static func changePassword(token: String, currentPassword: String, newPassword: String, confirmNewPassword: String, completion: @escaping (PwChangedUser?, APIError?) -> Void) {
        let url = Endpoint.changePW.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "currentPassword=\(currentPassword)&newPassword=\(newPassword)&confirmNewPassword=\(confirmNewPassword)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    
    
    
}

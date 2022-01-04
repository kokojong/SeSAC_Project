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
    
    static func allPosts(token: String, completion: @escaping (Post?, APIError?) -> Void) {
        let url = Endpoint.getPosts.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func writePost(token: String, text: String, completion: @escaping (PostElement?, APIError?) -> Void){
        let url = Endpoint.postPosts.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
}

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
}

class APIService {
    
    static func fetchRandomBeer(completion: @escaping (SignUp?,APIError?) -> Void) {
        let url = URL(string: "https://api.punkapi.com/v2/beers/random")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(SignUp.self, from: data) // 여기서 decodable 한거를 해야한다고 해서 위에 <T: Decodable>
                    completion(userData,nil)
                } catch {
                    completion(nil, .invalidData)
                    
                }
                
            }
            
        }.resume()
    }
    
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
//        let url = URL(string: "http://test.monocoding.com/auth/local")!
        let url = Endpoint.signIn.url
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpMethod = Method.POST.rawValue
        // string -> data, 딕셔너리 -> JSON시리어블 / 코더블
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func signUp(username: String, email: String, password: String, completion: @escaping (SignUp?, APIError?) -> Void) {
        let url = Endpoint.signUp.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
}

//
//  APIService.swift
//  SeSAC_week14
//
//  Created by kokojong on 2021/12/28.
//

import Foundation
enum APIError : Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
}

class APIService {
    
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com/auth/local")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // string -> data, 딕셔너리 -> JSON시리어블 / 코더블
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
//            print(data)
//            print(response)
//            print(error)
            
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
                let userData = try decoder.decode(User.self, from: data)
                completion(userData,nil)
            } catch {
                completion(nil, .invalidData)
                
            }
                
        }.resume()
        
    }
    
    // register
    static func register(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com/auth/local/register")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // string -> data, 딕셔너리 -> JSON시리어블 / 코더블
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
//            print(data)
//            print(response)
//            print(error)
            
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
                let userData = try decoder.decode(User.self, from: data)
                completion(userData,nil)
            } catch {
                completion(nil, .invalidData)
                
            }
                
        }.resume()
        
    }
    
    // board
    static func boards(token: String, completion: @escaping (Board?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com/boards")!
        
        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
        request.setValue("authorization", forHTTPHeaderField: "bearer \(token)")
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
//            print(data)
//            print(response)
//            print(error)
            
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
                let userData = try decoder.decode(Board.self, from: data)
                completion(userData,nil)
            } catch {
                completion(nil, .invalidData)
                
            }
                
        }.resume()
        
    }
    
    // lotto
    static func lotto(_ number: Int, completion: @escaping (Lotto?, APIError?) -> Void) {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
//            print(data)
//            print(response)
//            print(error)
            
            // 메인 쓰레드로 바꿔줌 -> 잘 이해 못함
//            print(Thread.isMainThread)
            
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
                    let userData = try decoder.decode(Lotto.self, from: data)
                    completion(userData,nil)
                } catch {
                    completion(nil, .invalidData)
                    
                }
                
            }
            
            
                
        }.resume()
        
        
        
    }
    
    // TMDB_actor
    static func person(_ text: String, page: Int, completion: @escaping (Person?, APIError?) -> Void) {
//        https://api.themoviedb.org/3/search/person?api_key=YOURKEY&language=en-US&query=%ED%98%84%EB%B9%88&page=1&include_adult=false&region=ko-KR
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        let language = "ko-KR"
        let key = "5d30a263c2ce99f0a519e8a598c4d176"
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "language", value: language)
        ]
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
//            print(data)
//            print(response)
//            print(error)
            
            // 메인 쓰레드로 바꿔줌 -> 잘 이해 못함
            
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
                    let userData = try decoder.decode(Person.self, from: data)
                    completion(userData,nil)
                } catch {
                    completion(nil, .invalidData)
                    
                }
                
            }
            
            
                
        }.resume()
        
        
        
    }
}

//
//  Endpoint.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/02.
//

import Foundation


enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum Endpoint {
    case signUp
    case signIn
//    case boardDetail(id: Int)
    case changePW
    case getPosts
    case getOnePost(postId: Int)
    case postPosts
    case updatePost(postId: Int)
    case deletePost(postId: Int)
    case getComment(id: Int)
    case postComment
    case updateComment(commentId: Int)
    case deleteComment(commentId: Int)
    
    
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signUp: return .makeEndPoint("auth/local/register")
        case .signIn: return .makeEndPoint("auth/local")
//        case .boardDetail(id: let id):
//            return .makeEndPoint("boards/\(id)")
        case .changePW: return .makeEndPoint("custom/change-password")
        case .getPosts, .postPosts: return .makeEndPoint("posts?_sort=created_at:desc")
        case .getOnePost(postId: let id): return .makeEndPoint("posts/\(id)")
        case .getComment(id: let id): return .makeEndPoint("comments?post=\(id)")
        case .postComment : return .makeEndPoint("comments")
        case .updatePost(postId: let postId), .deletePost(postId: let postId): return .makeEndPoint("posts/\(postId)")
        case .updateComment(commentId: let commentId), .deleteComment(commentId: let commentId): return .makeEndPoint("comments/\(commentId)")
        
        }
        
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:1231/"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
        
    }

}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult // return된 거를 써도되고 안써도 되고
    func dataTask2(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        
        return task
    }

    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        // shared 나 default 등을 쓰려고
        session.dataTask2(endpoint) { data, response, error in
//            print("data",data)
//            print("response",response)
//            print("error",error)
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
                    if response.statusCode == 401 {
                        completion(nil, .unauthorized)
                    } else {
                        completion(nil, .failed)
                    }
                    
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data) // 여기서 decodable 한거를 해야한다고 해서 위에 <T: Decodable>
                    completion(userData,nil)
                } catch {
                    completion(nil, .invalidData)
                    
                }
                
            }
            
            
            
        }
    }
}



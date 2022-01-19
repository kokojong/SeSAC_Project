//
//  Endpoint.swift
//  SeSAC_week14
//
//  Created by kokojong on 2021/12/29.
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
    case boards
    case boardDetail(id: Int)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signUp: return .makeEndPoint("auth/local/register")
        case .signIn: return .makeEndPoint("auth/local")
        case .boards: return .makeEndPoint("boards")
        case .boardDetail(id: let id):
            return .makeEndPoint("boards/\(id)")
        }
    }
}

extension URL {
    static let baseURL = "https://test.monocoding.com/"
    
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
                    let userData = try decoder.decode(T.self, from: data) // 여기서 decodable 한거를 해야한다고 해서 위에 <T: Decodable>
                    completion(userData,nil)
                } catch {
                    completion(nil, .invalidData)
                    
                }
                
            }
            
            
            
        }
    }
}


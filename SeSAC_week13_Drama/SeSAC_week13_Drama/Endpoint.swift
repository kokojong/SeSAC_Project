//
//  Endpoint.swift
//  SeSAC_week13_Drama
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
    case searchTVShow(key: String, query: String)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .searchTVShow(key: let key, query: let query):
            return .makeEndPoint("search/tv?api_key=\(key)&language=en-US&query=\(query)&page=1&include_adult=false")
        }
    }
}
// https://api.themoviedb.org/3/search/tv?api_key=5d30a263c2ce99f0a519e8a598c4d176&language=en-US&page=1&query=santa&include_adult=false
// https://api.themoviedb.org/3/search/tv?api_key=<<api_key>>&language=en-US&query=<<query>>&page=1&include_adult=false
extension URL {
    static let baseURL = "https://api.themoviedb.org/3/"
    
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
//            print("data:",data)
//            print("response:",response)
//            print("error:",error)
            
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

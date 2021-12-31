//
//  APIService.swift
//  SeSAC_week13_BeerCheers
//
//  Created by kokojong on 2021/12/30.
//

import Foundation

enum APIError : Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
}

class APIService {
    
    static func fetchRandomBeer(completion: @escaping (Beer?,APIError?) -> Void) {
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
                    let userData = try decoder.decode(Beer.self, from: data) // 여기서 decodable 한거를 해야한다고 해서 위에 <T: Decodable>
                    completion(userData,nil)
                } catch {
                    completion(nil, .invalidData)
                    
                }
                
            }
            
        }.resume()
    }
    
}

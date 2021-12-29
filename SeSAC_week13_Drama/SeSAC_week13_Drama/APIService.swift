//
//  APIService.swift
//  SeSAC_week13_Drama
//
//  Created by kokojong on 2021/12/29.
//

import Foundation

enum APIError : Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
}

class APIService {
    
    static let APIKEY: String = "5d30a263c2ce99f0a519e8a598c4d176"
    
    static func searchTVShow(searchText: String, completion: @escaping (TVShow?, APIError?) -> Void) {
        
        let url = Endpoint.searchTVShow(key: APIKEY, query: searchText).url
        print("url: ",url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.request(endpoint: request, completion: completion)
        
        
        }
        
}

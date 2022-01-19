//
//  APIService.swift
//  SeSAC_week13
//
//  Created by kokojong on 2021/12/21.
//

import Foundation

class APIService {
    
    let sourceURL = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/people/searchPeopleList.json?key=f5eef3421c602c6cb7ea224104795888")!
    
    
    // 영진원
    func requestCast(completion: @escaping (Cast?) -> Void)  {
        URLSession.shared.dataTask(with: sourceURL) { data, response, error in
            print(data)
            print(response) // meta data를 가지고 있다
            print(error)
            
            if let error = error { // 해제를 했는데 있다면
                print("error 발생",error)
                self.showAlert(.unknownError)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                self.showAlert(.serverError)
                return
            }
            
            if let data = data, let castData = try? JSONDecoder().decode(Cast.self, from: data) {
                print("Succeed\n",castData)
                completion(castData)
                return
            }
            completion(nil)
            
        }.resume() // trigger
    }
    
    func showAlert(_ msg: APIError) {
        // alert 띄우기
    }
}

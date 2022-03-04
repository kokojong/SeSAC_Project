//
//  APIService.swift
//  SeSAC_week23_Test
//
//  Created by kokojong on 2022/03/03.
//

import Foundation

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

final class APIService {
    
    let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=950"
    
    var number1 = 0
    
    func callRequest(completion: @escaping (Int) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        // Error가 nil -> 성공 -> Data, Response는 nil이 아님
        // Error가 nil이 아님 -> 실패 -> Data, Response는 nil
        // 둘중에 하나만 nil -> Result Type
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                return
                
            }

            guard let data = data else {
                return
            }

            do {
                let value = try JSONDecoder().decode(Lotto.self, from: data)
//                self.number1 = value.drwtNo1
                completion(self.number1)
                
            } catch {
                return
            }
            
           
        }
        
        task.resume()
        
    }
}

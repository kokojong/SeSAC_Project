//
//  VisionAPIManager.swift
//  SeSAC_week5_network
//
//  Created by kokojong on 2021/10/27.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit.UIImage // 특정한것만 임포트

class VisionAPIManager {
    
    static let shared = VisionAPIManager()
    
    func fetchFaceData(image: UIImage, result: @escaping (Int, JSON) -> () ) {
        
        let url = EndPoint.visionURL
        let header: HTTPHeaders = [
            "Authorization": APIKey.KAKAO,
            "Content-Type": "multipart/form-data" // 이부분을 지워도 동작하긴 하는데..?
            // 라이브러리에서 헤더가 내장되어있기 때문 - 디폴트가 multipart/form-data
        ]
        
        // UIImage를 바이너리 타입으로 변환
        guard let imageData = image.pngData() else { return }
        
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "kokojong") // fileName은 바꿔도된다
        }, to: url, headers: header)
            .validate(statusCode: 200...500).responseJSON { response in
                
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let code = response.response?.statusCode ?? 500
                
                result(code,json)
                
            case .failure(let error): // 네트워크 통신이 안될 때
                print(error)
            }
        }
        
    }
}

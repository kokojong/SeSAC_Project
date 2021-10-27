//
//  Constants.swift
//  SeSAC_week5_network
//
//  Created by kokojong on 2021/10/27.
//

import Foundation

struct APIKey {
    
    static let NAVER_ID = "sHXg6cdzeK4giS0SuZA2"
    static let NAVER_SECRET = "yrsXMsOkxI"
    
    static let KAKAO = "KakaoAK bd7d8a99fc62b4b01ff00e4c82f91082"
    
    static let OPEN_WEATHER = "cbb08215c4818146e8ec274c270bdce9"
    
}

struct EndPoint {
    
    static let papagoURL = "https://openapi.naver.com/v1/papago/n2mt"
    
    static let visionURL = "https://dapi.kakao.com/v2/vision/face/detect"
    
    static let openWeatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    
    static let kakaoOCRURL = "https://dapi.kakao.com/v2/vision/text/ocr"
}

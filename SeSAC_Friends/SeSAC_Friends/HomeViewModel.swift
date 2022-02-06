//
//  HomeViewModel.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/06.
//

import Foundation

class HomeViewModel {

    static let shared = HomeViewModel()
    
    var onQueueResult: Observable<OnQueueResult> = Observable(OnQueueResult(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    
    var centerRegion = Observable(0)
    var centerLat = Observable(0.0)
    var centerLong = Observable(0.0)
    
    func searchNearFriends(form: OnQueueForm, completion: @escaping (OnQueueResult?, Int?, Error?) -> Void) {
        QueueAPIService.onQueue(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!, form: form) { onqueueResult, statuscode, error in
            
            guard let onqueueResult = onqueueResult else {
                return
            }
            
            self.onQueueResult.value = onqueueResult

            completion(onqueueResult, statuscode, error)
            
        }
        
    }
    
    func calculateRegion(lat: Double, long: Double) {
        
        var strLat = String(lat+90)
        var strLong = String(long+180)
        
        strLat = strLat.components(separatedBy: ["."]).joined()
        strLong = strLong.components(separatedBy: ["."]).joined()
        
        let strRegion = strLat.substring(from: 0, to: 4) + strLong.substring(from: 0, to: 4)
        
        centerRegion.value = Int(strRegion) ?? 0
        print(#function,centerRegion.value)
    }
    
    
}
//
//  LottoViewModel.swift
//  SeSAC_week14
//
//  Created by kokojong on 2021/12/28.
//

import Foundation

class LottoViewModel {
    
    var lotto1 = Observable(1)
    var lotto2 = Observable(11)
    var lotto3 = Observable(21)
    var lotto4 = Observable(31)
    var lotto5 = Observable(41)
    var lotto6 = Observable(2)
    var lotto7 = Observable(12)
    
//    var lottoPrize: Observable<Int> = Observable(nil) optional
    var lottoPrize: Observable<String> = Observable("0")
    
    
    
    func fetchLottoAPI(_ number: Int) {
        APIService.lotto(number) { lotto, error in
            
            guard let lotto = lotto else {
                return
            }
            
            // 여기에 main쓰레드로 작업해줘도 된다
            // API 서비스에 하는 이유 -> 뷰모델에서 api콜을 여러가지 동시에 사용할 경우 너무 많은 main쓰레드 호출이 된다.(확장성을 위해서 이렇게 한다)
            self.lotto1.value = lotto.drwtNo1
            self.lotto2.value = lotto.drwtNo2
            self.lotto3.value = lotto.drwtNo3
            self.lotto4.value = lotto.drwtNo4
            self.lotto5.value = lotto.drwtNo5
            self.lotto6.value = lotto.drwtNo6
            self.lotto7.value = lotto.bnusNo
            
            self.lottoPrize.value = self.format(for: lotto.firstWinamnt)
            
        }
    }
    
    func format(for number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: number)!
        return result
    }
}

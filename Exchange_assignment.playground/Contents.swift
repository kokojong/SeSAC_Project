import UIKit

struct ExchangeRate {
    
    // 옵저버를 달아줌
    var currencyRate : Double {
        willSet {
            print("currencyRate willSet - 환율 변동 예정 \(currencyRate) -> \(newValue)")
        }
        didSet {
            print("currencyRate didSet - 환율 변동 예정 \(oldValue) -> \(currencyRate)")
        }
        
    }
    
    // 옵저버를 달아줌
    var USD : Double {
        willSet {
            print("USD willSet - 환전금액 : USD:\(newValue)달러로 환전 될 예정")
        }
        didSet {
            print("USD didSet - KRW :\(KRW)원 ->\(USD)달러로 환전 완료")
        }
    }
    
    var KRW : Double {
        get {
            return USD * currencyRate
        }

        set(krw) {
            USD = krw / currencyRate
        }
    }
    
}

var rate = ExchangeRate(currencyRate: 1100, USD: 1)
rate.KRW = 500000

rate.currencyRate = 1350
rate.KRW = 500000

//: [Previous](@previous)

import Foundation

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    
    func incrementer() -> Int {
        runningTotal += amount // runningTotal, amount를 내부적으로 저장하고 있어따! (캡쳐)
        return runningTotal
    }
    
    return incrementer
    
}

let incrementByTen = makeIncrementer(forIncrement: 10) // incrementByTen -> incrementer

incrementByTen()
incrementByTen()
incrementByTen()

func firstClosure() {
    
    var number = 0
    print("1: \(number)")
    
    // number를 내부적으로 저장(캡쳐) 하고 있음 = 값타입이므로 복사
    // 구조체, 값, 복사 -> 클래스처럼 참조가 되는 형태로 복사가 되고있다
    // 결론 -> 클로저: 무조건 캡쳐를 참조타입으로 하고있따! -> Reference Capture
//    let closure: () -> Void = {
//        number = 50
//        print("closure: \(number)")
//    }
    
    // 참조형 캡쳐하려면!
    // [number] 복사해서 사용할 수 있고, 외부와 독립적인 형태로 값 사용가능 + 상수로 캡쳐
    let closure: () -> Void = { [number] in
//        number = 50 // error: cannot assign to value: 'number' is an immutable capture
        print("closure: \(number)")
    }
    closure()
    
    number = 100
    closure()
    print("2: \(number)")
    
}

firstClosure()

class User {
    var nickname = "jack"
    
    // [weak self]를 추가해서 deinit이 된다
    // 없으면 스스로 순환참조를 하기 때문에 rc가 1로 남아서 메모리에서 빠지지 않는다
    // 약한 참조로 값을 가져오기 위함!
    lazy var introduce: () -> String = { [weak self] in
        
//        guard self = self else { return }
        
        return self?.nickname ?? ""
    }
    
    deinit {
        print("User deinit")
    }
}

var nickname: User? = User()

nickname?.introduce

nickname = nil

//: [Next](@next)


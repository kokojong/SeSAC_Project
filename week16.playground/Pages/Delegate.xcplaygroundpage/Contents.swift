//: [Previous](@previous)

import Foundation

protocol MyDelegate: AnyObject {
    func sendData(_ data: String)
}

class Main: MyDelegate {
    
    lazy var detail: Detail = {
        let view = Detail()
        view.delegate = self
        return view
    }()
    
    func sendData(_ data: String) {
        print("\(data)를 전달받아따")
    }
    
    deinit {
        print("Main deinit")
    }
}

class Detail {
    
    weak var delegate: MyDelegate?
    // error: 'weak' must not be applied to non-class-bound 'MyDelegate'; consider adding a protocol conformance that has a class bound
    // MyDelegate: AnyObject 를 통해 해결

    
    func dismiss() {
        delegate?.sendData("안녕")
    }
    
    deinit {
        print("Detail deinit")
    }
    
    
}

var main: Main? = Main()
main?.detail
main = nil
// deinit이 되지 않음(lazy 때문에)

//: [Next](@next)

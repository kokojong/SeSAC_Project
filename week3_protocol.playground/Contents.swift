import UIKit


protocol Introduce {
    // 필수 요건
    var name : String {
        get set
    }
    
    var age : Int {
        get
    }
    
    func introduce()
    
}

class Human {
    
}

class Jack : Human, Introduce {
    var name: String = "Jack"
    
    var age: Int = 10
    
    func introduce() {
        print("자기소개")
    }
    
    
}

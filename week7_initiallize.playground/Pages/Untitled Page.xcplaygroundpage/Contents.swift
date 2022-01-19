import Foundation
import UIKit

class User {
    var name: String = ""
    var age: Int = 0
}

struct UserStruct {
    var name: String = ""
    var age: Int = 1
    
}

// 몇개만 초기화 하고 몇개는 고정하려고 한다면 -> extension으로 해야 빨간줄 안뜸
extension UserStruct {
    init(age: Int) {
        self.name = "손님" // 얘는 고정
        self.age = age // 얘는 입력
    }
}

// 인스턴스를 만들때 저장 프로퍼티는 초기화를 해줘야한다.
let a = User() // 초기화 구문, 초기화 메서드 -> Default Initiallizer
let b = UserStruct(name: "bb", age: 3)  // Memberwise Initiallizer
let c = UserStruct() // 디폴트 이니셜라이져 사용
let d = UserStruct(age: 5) // extension사용 해서 이름은 '손님'을 디폴트로 갖게함


let color = UIColor(red: 0.5, green: 0.5, blue: 1.0, alpha: 1)
let color2 = UIColor.init(red: 0.4, green: 0.4, blue: 1.0, alpha: 1)
// .init 초기화 메서드를 생략해서 쓰고있었다

// 편의 생성자(convenience initiallizer)
class Cofffee {
    
    let shot: Int
    let size: String
    let menu: String
    let mind: String
    
    
    // Designated initiallizer(지정 생성자)
    init(shot: Int, size: String, menu: String, mind: String){
        self.shot = shot
        self.size = size
        self.menu = menu
        self.mind = mind
    }
    
    // 기본(2샷 보통)
    convenience init(value: String){
        self.init(shot: 2, size: "보통", menu: value, mind: "열심히")
        
    }
    
}

let coffee = Cofffee(shot: 2, size: "tall", menu: "아아", mind: "대애충")
let coffee2 = Cofffee(value: "마끼ㅑ또")


extension UIColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255,alpha: 1)
    }

}

let customColor = UIColor(red: 28, green: 12, blue: 205)

// 2. 프로토콜 초기화 구문
// 프로토콜 - 프로퍼티, 메서드, 초기화 구문
protocol Jack {
    // 특정한 값이 들어가지 않도록 초기화 하지 않는다
//    var name = "jack"
    // getter setter -> 연산 / 저장 프로퍼티로 사용가능하다 -> 찾아보기
//    func welcome()
    init() // 프로토콜에서 init을 추가하는 것.
}

class Hello: Jack {
    
    required init() { // required ?? -> 프로토콜에서 초기화(init) 구문이 정의 되어있다면 구분을 해줘야한다(프로토콜에서 온거라고 명시)
    }
    
    func welcome() {
        print("welcome")
    }
}

class HelloBrother: Hello {
    
    required init() {
        
    }
    
}

// 프로토콜 x
class Hello2 {
    init() {
        print("hello2")
    }
}

class HelloBrother2 : Hello2, Jack { // 둘다 초기화를 가지고 있다
    
    required override init() { // Jack 과 Hello2 에 모두 초기화 구문이 있어서
        super.init()
        print("HelloBrother2")
    }
}

let hello = HelloBrother2() // HelloBrother2 hello2가 프린트 된다


// 3. 초기화 구문 델리게이션 

class A {
    
    var value: Int
    
    init() {
        value = 10
    }
}

class B: A {
    override init() {
        super.init()
        print("B")
    }
}

class C: B {
    
    override init() {
        super.init()
    }
    
    deinit {
        print("deinit")
    }
    
}

var test: C? = C()
test = nil
// B deinit가 프린트

// super를 따라가서 결국 최상단에서 초기화 하는거가 된다



import UIKit

/*
var apple = 8
var banana = 3

print(apple, banana)
// inout parameter
swap(&apple, &banana)
print(apple, banana)
*/

func swapTwoInts(a: inout Int, b: inout Int) {
    print("swapTwoInts")
    let tmpA = a
    a = b
    b = tmpA
}

//swapTwoInts(a: &10, b: &11)

func swapTwoDoubles(a: inout Double, b: inout Double) {
    print("swapTwoDoubles")
    let tmpA = a
    a = b
    b = tmpA
}

var double1 = 3.1
var double2 = 2.5
//swapTwoDoubles(a: &3.1, b: &2.5)
swapTwoDoubles(a: &double1, b: &double2)
print(double1,double2)

// Jack은 타입 파라미터다 - 함수를 정의시에 타입을 모른다, 함수를 호출시에 매개변수 타입으로 대체되는 placeHolder(임시적인 이름이다)
// 대부분 <T> 를 사용
func swapTwoValues<Jack>(a: inout Jack, b: inout Jack) {
    print("swapTwoValues")
    let tmpA = a
    a = b
    b = tmpA
}

func swapTwoValues2<T>(a: inout T, b: inout T) {
    print("swapTwoValues2")
    let tmpA = a
    a = b
    b = tmpA
}

var test1 = 3.3
var test2 = 5.5
swapTwoValues2(a: &test1, b: &test2)
print(test1, test2)

// 만약에 같은 함수명, 같은 매개변수로 한다면? -> overloading
// 그래서 T를 한거보다 타입을 정해준게 우선순위가 있다!


func totalSum(a: [Int]) -> Int {
    return a.reduce(0,+)
}

func totalSum(a: [Double]) -> Double {
    return a.reduce(0,+)
}
func totalSum(a: [Float]) -> Float {
    return a.reduce(0,+)
}

// Generic
// 프로토콜 제약 <T:Numeric>
// <T:BinaryInteger> 등도 사용이 가능함
func totalSum<T:Numeric>(a: [T]) -> T {
    return a.reduce(.zero, +) // 시작값이 0으로 하면 다른 타입에서 안되므로 .zero를 사용
    // +를 그냥 쓰자니 T에는 struct enum등 모든걸 가능하다고 하는거라서 안된다
    
}

totalSum(a: [1,2,3])

// 문자열을 더하고 싶다면?
// AdditiveArithmetic - 덧셈이 가능한 경우(숫자, string)
func totalSum<T:AdditiveArithmetic>(a: [T]) -> T {
    return a.reduce(.zero, +)
}

//totalSum(a: ["아","으"])

struct Stack<T> {
    var items = [T]()
    
    mutating func push(_ item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        items.removeLast()
    }
}

extension Stack {
    var topElement: T? {
        return self.items.last
    }
}

extension Array {
    var topElement: Element? { // 얘는 애초에 Element로 정의 된거라서 이거만 써야함
        return self.last
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("하")
stackOfStrings.push("이")
stackOfStrings.push("하")
stackOfStrings.push("이")
stackOfStrings.pop()

print(stackOfStrings)

var array: [String] = []
var array2 = Array<String>()

func equal<T: Equatable>(a: T, b: T) -> Bool {
    // T: Animal 처럼 다른 클래스를 받을 수 있음
    return a == b // 다른 타입에서는 ==이 불가능한 경우가 많다 -> equatable 프로토콜을 추가
}

equal(a: 3, b: 4)

class Animal: Equatable {
    
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.name == rhs.name
    }
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let one = Animal(name: "개")
let two = Animal(name: "개")

//print(one == two) // class로 된거라서 비교가 불가능 -> Equatable을 추가하기
print( one == two)


// Generic을 어떻게 이용할건데? -> 화면 전환을 전체적으로 통일하기
import UIKit

class ViewController: UIViewController {
    
    func transitionViewController<T: UIViewController>(sb: String, vc: T) {
        let sb = UIStoryboard(name: sb, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vc) as! UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
}



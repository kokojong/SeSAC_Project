import UIKit

import Foundation

var sample = Array(repeating: "가", count: 100)

sample.count
sample.capacity

sample.append(contentsOf: Array(repeating: "나", count: 100))

sample.count
sample.capacity

var sample2 : [Int] = []

for i in 1...200 {
    sample2.append(i)
    sample2.count
    sample2.capacity
}

var str = "Hello World! - hello".replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "-", with: " ")
var t = "Squid Game".replacingOccurrences(of: " ", with: "_").lowercased() // -> Squid_Game -> squid_game



// 10.21(목) 일급 객체

// 1. 1급 객체 - 변수나 상수에 함수를 대입할 수 있음(함수가 1급 객체이다)

// 변수나 상수에 함수를 대입할 수 있음
func checkBankInfomation (bank: String) -> Bool {
    let bankArray = ["우리","국민","신한"]
    return bankArray.contains(bank) ? true : false
}

// 변수나 상수에 함수를 실행하고 나온 반환값을 대입
let checkResult = checkBankInfomation(bank: "우리") // Bool

// 변수나 상수에 함수 '자체'를 대입할 수 있다
let account = checkBankInfomation // 단지 함수를 대입 -> 함수가 실행되지는 않는다
account("신한") // 함수를 호출해줘야 함수가 실행이 된다.

// (String) -> Bool 이 뭘까?(실행없이 함수를 부르면) -> Function Type
let tupleExample : (Int, Int, String, Bool) = (1, 2, "hi", true) // 튜플의 타입은 유동적
tupleExample.1 // 1번 인덱스

// Function Type 1. (String) -> String
func hello(nickname: String) -> String {
    return "저는 \(nickname)입니다"
}

// 1-1
func hello(username: String) -> String { // 같은 이름이고 타입이 같다면?? -> 식별자가 필요하게 된다
    return "저는 \(username)입니다"
}

// Function Type 2. (String, Int) -> String
func hello(nickname: String, userAge: Int) -> String {
    return "저는 \(nickname), \(userAge)살 입니다"
}

// Function Type 3. () -> Void, () -> ()
// typealias Void = ()
func hello() -> Void {
    print("안녕하세오")
}

typealias ko = String // 타입을 지정

// 함수를 구분하기 힘들때(동일한 이름) 타입 어노테이션을 통해서 함수를 구별할 수 있다.
let a: (String) -> String = hello(nickname: ) // 1번의 경우가 담아짐 -> 동일한 타입 어노테이션이 있다면 오류가 발생(식별자가 필요)
let b: (String, Int) -> String = hello(nickname:userAge:)  // 2번의 경우가 담아짐

// 함수를 구분하기 힘들때 함수의 식별자로 구분할 수 있다.(탸ㅏ입 어노테이션을 생략하더라도 함수를 구분할 수 있음)
let c: (String) -> String = hello(username:) // 1-1

// b를 함수처럼 사용이 가능하다
b("minsu", 30)
b("hello", 20)

                                       
// 2. 함수의 반환 타입으로 함수를 사용할 수 있다, 구조체 클래스 등 반환값으로 사용할 수 있음
func currentAccount() -> String {
    return "계좌 있음"
}

func noCurrentAccount() -> String {
    return "계좌 없음"
}


// 가장 왼쪽에 위치한 ->를 기준으로 오른쪽에 놓인 모든 타입은 반환값을 의미한다
func checkBank (bank: String) -> () -> (String) {
    let bankArray = ["우리","국민","신한"]
    return bankArray.contains(bank) ? currentAccount : noCurrentAccount // 함수를 호출하는건 아니고 함수를 던져줌
}
let minsu = checkBank(bank: "농협") // 함수 자체만 대입
minsu() // "계좌 없음"

// 2-1. Calculate (Int, Int) -> Int
func plus(a: Int, b: Int) -> Int {
    return a + b
}

func minus(a: Int, b: Int) -> Int {
    return a - b
}

func multiply(a: Int, b: Int) -> Int {
    return a * b
}

func divide(a: Int, b: Int) -> Int {
    return a / b
}

func calculate(operand: String) -> (Int, Int) -> Int {
    switch operand{
    case "+": return plus
    case "-": return minus
    case "*": return multiply
    case "/": return divide
    default: return plus
    }
}

let result = calculate(operand: "-") // 함수가 실행되는건 아님
result(5,3)
let result2 = calculate(operand: "+")(3,2) // 한줄에 실행은 되나 가독성을 위해서 나눠서 작성한다



// 3. 함수의 인자값으로 함수를 사용할 수 있다.
// 콜백 함수로 자주 사용된다. 콜백함수 : 특정 구문의 실행이 끝나면 시스템이 호출하도록 처리된 함수

// () -> ()
func oddNumber() {
    print("홀수")
}

func evenNumber() {
    print("짝수")
}

func resultNumer(base: Int, odd: () -> (), even: () -> () ) {
    return base.isMultiple(of: 2) ? even() : odd()
}

resultNumer(base: 9, odd: oddNumber, even: evenNumber) // 매개변수로 함수를 전달한다

func plusNumber() {
    print("더하기")
}

func minusNumber() {
    print("빼기")
}

// 어떤 함수가 들어가는 것과 상관없이, 다지 타입만 잘 맞으면 된다
// 실질적인 연산은 인자값으로 받는 함수에 달려있어서, 중개 역할만 담당한다고 해서 브로커라고 부른다
resultNumer(base: 9, odd: plusNumber, even: minusNumber) // 이렇게 하려고 한게 아닌데도 들어가버림

resultNumer(base: 9) { // 이름 없는 함수(익명 함수), 첫 매개변수의 이름이 사라짐
    print("성공")
} even: {
    print("실패")
}

// 클로저의 유래 닫혀있다. 외부 함수 <-> 내부 함수(클로저)

func drawingGame(item: Int) -> String {
    
    func luckyNumber(number: Int) -> String {
        return "\(number * Int.random(in: 1...5))"
    }
    let result = luckyNumber(number: item * 2)
    
    return result
}

drawingGame(item: 10)

// 내부함수를 반환하는 외부함수로 만들 수 있다
func drawingGame2(item: Int) -> (Int) -> String {
    
    // 내부함수에서 외부함수의 요소인 item을 캡쳐해서 외부 생명주기가 끝났어도 사용이 가능함 (클로저 캡쳐)
    func luckyNumber(number: Int) -> String {
        return "\(item * number * Int.random(in: 1...5))"
    }
    
    return luckyNumber
}
drawingGame2(item: 10) // 내부의 함수는 아직 동작하지 않음
let luckyNumber2 = drawingGame2(item: 10) // 외부함수는 생명주기가 끝남(내부함수도 끝나있어야 한다고 생각하는데 아님)
luckyNumber2(2) // 외부함수 생명주기가 끝나더라도 내부함수는 계속 사용이 가능하다

// 은닉성()이 있는 내부 함수를 외부함수의 실행 결과로 반환하면서 내부 함수를 외부에서도 접근 가능하게 되었음
// 이제 얼마든지 호출이 가능. 이건 생명주기에도 영향을 미침. 외부 함수가 종료되더라도 내부 함수는 살아있음


// 드디어..! 클로저를 봅시다
// 같은 정의를 갖는 함수가 서로 다른 환경을 저장하는 결과가 생기게 됨
// 클로저에 의해 내부 함수 주변의 지역변수나 상수도 함께 저장됨. -> 값이 캡쳐되었다고 표현함
// 주변 환경에 포함된 변수나 상수의 타입이 기본 자료형이나 구조체 자료형일때 발생함. 클로저 캡쳐 기본 기능임


// => 스위프트는 특히 이름없는 익명함수로 클로저를 사용하고 있고, 주변환경(내부 함수 주변의 변수나 상수)로부터 값을 캡쳐할 수 있는 '경량 문법'으로 많이 사용한다
// -> 원리는 이렇지만 실제로는 가볍게 사용하는 편이다

// () -> ()
func studyiOS() {
    print("iOS 공부")
}

let studyiOSHarder = {
    print("iOS 빡공")
}
// '클로저 헤더' in '클로저 바디'  형태로 사용
let studyiOSharder2 = { () -> ()  in
    print("iOS 빡빡공")
}

studyiOSharder2()

func getStudyWithMe(study: () -> () ) {
    study()
}

// inline 클로저
getStudyWithMe(study: { () -> ()  in
    print("iOS 빡빡공")
})

getStudyWithMe(study: studyiOSharder2)

// 함수 뒤에 클로저가 실행 (트레일링 클로저)
getStudyWithMe() { () -> ()  in
    print("iOS 빡빡공")
}

func todayNumber(result: (Int) -> String) {
    result(Int.random(in: 1...100))
}

todayNumber(result: { (number: Int) -> String in
    return "행운의 숫자는 \(number)입니다"
})

// 위와 같은 표현
todayNumber(result: { (number) in
    return "행운의 숫자는 \(number)입니다"
})

// 매개변수가 생략되면 할당된 내부 상수 $0 을 사용할 수 있다($0 $1 ...)
todayNumber(result: {
    return "행운의 숫자는 \($0)입니다"
})

// 리턴도 생략가능
todayNumber(result: {
    "행운의 숫자는 \($0)입니다"
})

// 최종 생략버전
todayNumber() { "\($0)" }


// 매개변수를 마음대로 설정 가능, 경량 문법
todayNumber { value in
    print("kkk")
    return "\(value) 입니다"
}

// @autoClosure @escaping

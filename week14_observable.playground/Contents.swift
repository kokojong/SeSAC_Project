import UIKit
import Foundation

class Observable<T> {
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void ){
        closure(value)
        listener = closure
    }
}

class User<T> {
    var listener: ((T) -> Void)?
    
    var name: T {
        didSet {
//            changeName() // 변경이 된다면 함수가 호출된다
            listener?(name) // 아래에서 Optional을 해제해줬음
        }
    }
    
    // class라서 초기화 구문 필요
    init(_ name: T){
        self.name = name
    }
    
    func changeName(_ completion: @escaping (T) -> Void) {
        completion(name) // name을 전달하겠다
        listener = completion // 같은 타입이기 때문에 넣어줘서 optional하지 않도록 한다
        print("이름이 변경 되었습니다")
    }
    
    
    
}

let jack = User("jackjack")
let v = Observable("vv") // 초기화
//jack.changeName()
jack.name = "kokojong"


//////

func hello(name: String, age: Int) -> String {
    return "\(name), \(age)살"
}
let a: String = hello(name: "hihi", age: 3)
type(of: a)

let b = hello // 함수의 타입만 담음

let c: (String, Int) -> String = hello

c("bb",2)

var listener:  (() -> Void)? // 함수 타입을 받을 수 있도록 준비된 상태


/////

struct Endpoint {
    static let baseURL = "https://test.monocoding.com/"
    static let signUpURL = baseURL + "auth/local/register"
    static let signInURL = baseURL + "auth/local"
    static let boardURL = baseURL + "boards"
}

//URLSession.shared.dataTask(with: Endpoint.signUpURL)

/*
 boards/200: 게시물, detail
 
 */

enum Endpoint2 {
    case signUp
    case signIn
    case boards
    case boardDetail(id: Int)
}

extension Endpoint2 {
    var url: URL {
        switch self {
        case .signUp: return .makeEndPoint("auth/local/register")
        case .signIn: return .makeEndPoint("auth/local")
        case .boards: return .makeEndPoint("boards")
        case .boardDetail(id: let id):
            return .makeEndPoint("boards/\(id)")
        }
    }
}

extension URL {
    static let baseURL = "https://test.monocoding.com/"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
        
    }
    
    static var login: URL {
        return makeEndPoint("auth/local")
    }
    
    static func boardDetail(num: Int) -> URL {
        makeEndPoint("boards/\(num)")
    }
}

URLSession.shared.dataTask(with: .login)
URLSession.shared.dataTask(with: Endpoint2.signUp.url)
print(Endpoint2.signIn.url)
print(Endpoint2.boardDetail(id: 200).url)

class A {
    static func a() { // 타입 메서드
        
    }
    func c() { // 인스턴스 메서드
        
    }
    
    class func b() { // 상속, 오버라이딩이 가능
        
    }
}

A.a()
A.b()
//A.c(A)


class B: A {
    override func c() {
        
    }
    
    
}

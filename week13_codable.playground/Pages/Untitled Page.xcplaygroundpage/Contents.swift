import UIKit
import Foundation


let json = """
{
"quote_content": "You cannot afford to live in potential for the rest of your life; at some point, you have to unleash the potential and make your move.",
"author_name": "Eric Thomas"
}
"""

// class struct enum
struct Quote: Decodable {
    var quoteContent: String
    var authorName: String
    
    enum CodingKeys: String, CodingKey { // 항상 내부적으로 생성이 되어있음
        case quote = "quote_content"
        case author = "author_name"
    }
}

// string -> data
guard let result = json.data(using: .utf8) else { fatalError() }

// decoder
let decoder = JSONDecoder()
//decoder.keyDecodingStrategy = .convertFromSnakeCase
        
// data -> quote
do {
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
} catch {
    print(error)
}

/*  옵셔널
 keyDecodingStrategy = .convertFromSnakeCase
 custom key - codingkey
 
 
 */



// Meta Type
// quote의 타입은?
// String 의 타입은 string.type  메타 타입은 클래스 구조체 열거형 등의 유형 자체를 가르킴
let name = "kokojong"
type(of: name)
// Quote: 인스턴스에 대한 타입, Quote구조체의 타입은 뭐야? Quote.type
//let quote: Quote = Quote(quote: "asd", author: "kkk")
//type(of: quote)

struct User {
    var name = "koko"
    static let identifier = 1234 // 타입 프로퍼티
}

let user = User()
user.name
type(of: user)
// 아래 3개 동일
type(of: user).identifier
User.identifier
User.self.identifier

User.self.init(name: "")

// 이를 잘 활용하면 컴파일 때가 아니라 런타임 때의 타입을 알 수 있다
let age: Any = 15
type(of: age) // int.type


//: [Previous](@previous)

import Foundation

struct User: Encodable {
    var name: String
    var signUpDate: Date
    var age: Int
}

let users: [User] = [
    User(name: "koko", signUpDate: Date(), age: 28),
    User(name: "bae", signUpDate: Date(timeInterval: -86400, since: Date()), age: 2),
    User(name: "chu", signUpDate: Date(timeIntervalSinceNow: 86400*2), age: 5)
]

dump(users)

let encode = JSONEncoder()
encode.outputFormatting = .prettyPrinted
encode.dateEncodingStrategy = .iso8601 // iso 국제 표준화 기구
//encode.outputFormatting = .sortedKeys

let format = DateFormatter()
format.locale = Locale(identifier: "ko-KR")
format.dateFormat = "yyyy MM dd"
encode.dateEncodingStrategy = .formatted(format)

do {
    let jsonData = try encode.encode(users)
    guard let jsonString = String(data: jsonData, encoding: .utf8) else {fatalError()}
    print(jsonString) // json -> zip -> 외부
} catch {
    print(error)
}

//: [Previous](@previous)

import Foundation

func checkDateFormat(text: String) -> Bool {
    let format = DateFormatter()
    format.dateFormat = "yyyyMMdd" // YYYY도 되기는 하는데 외국에서 하듯이 주차?로 판단함(의도와 달라질 수 있음)
    
    return format.date(from: text) == nil ? false : true
}


func validateUserInput(text: String) -> Bool {
    // 입력한 값이 비었는지
    guard !(text.isEmpty) else {
        print("빈값")
        return false
    }
    
    // 입력한 값이 숫자인지 아닌지
    guard Int(text) != nil else {
        print("숫자가 아닙니다")
        return false
    }
    
    // 입력한 값이 날짜형태로 변환이 되는 숫자인지 아닌지
    guard checkDateFormat(text: text) else {
        print("날짜 형태가 잘못되었다")
        return false
    }
    
    
    
    return true
}

if validateUserInput(text: "20200000") {
    print("검색 가능")
} else {
    print("검색 불가")
}

// 오류 처리 패턴
// 컴파일러가 오류의 타입을 인정하게 된다
enum ValidationError: Int, Error {
    case emptyString = 401
    case isNotInt = 402
    case isNotDate = 403
}

// enum을 이용하기
func validateUserInputError(text: String) throws -> Bool {
    guard !(text.isEmpty) else {
        throw ValidationError.emptyString
    }
    
    guard Int(text) != nil else {
        throw ValidationError.isNotInt
    }
    
    guard checkDateFormat(text: text) else {
        throw ValidationError.isNotDate
    }
    
    // 중간에 어디서든 걸리면 구문을 벗어나게 된다
    return true
}

do {
    let result = try validateUserInputError(text: "20211101") // 일단 시도(throws와 매칭)
//    let result = try validateUserInputError(text: "") // -> 401
    print(result, "성공~")
} catch ValidationError.emptyString {
    print("emptyString", ValidationError.emptyString.rawValue)
} catch ValidationError.isNotInt {
    print("isNotInt")
} catch ValidationError.isNotDate {
    print("isNotDate")
}

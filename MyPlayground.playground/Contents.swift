import UIKit

// optional 하지 않음
var email : String? = "kokojong@a.com"
type(of: email)
//email = nil // 그래서 nil이 불가능, String? 이라고 사용하면 nil값이 가능

var gender : Bool = true // 할당 연산자

print("회원 정보 : \(email), \(gender)")

if email == nil {
    print("이메일이 nil")
} else {
    print(email!) // nil은 위에서 걸러줌
}

// 삼항연산자 ? ㅇㅇ : ㄴㄴ
let result = email != nil ? email! : "이메일이 nil"
print(result)


// 텍스트필드의 경우, 텍스트 필드에 작성되는 모든 글자는 문자로 인식이 된다(string)
var phoneNumber = "01012341234"
type(of: phoneNumber)

// 1. 숫자가 맞는지?를 체크 2. 숫자 카운트(몇자리인지, 숫자가 아닌것도 있는지) 3. 비어있는 경우

var intPhoneNumber =  Int(phoneNumber) // 형변환 string -> int
type(of: intPhoneNumber)

// var number : Int8 = 1600
// 오버플로우

Int8.min
Int8.max
UInt8.min
UInt8.max

var foodList : [String] = ["도넛", "아이스크림","크로플"]
type(of: foodList)
foodList.insert("초콜릿", at:1)
foodList.append("커피")
foodList.append(contentsOf: ["aa","bb"])
print(foodList)

var numberArray = [Int](1...10)
//numberArray = Array(repeating: 0, count: 10)
//numberArray.shuffle() // 순서를 섞음
print(numberArray)

var sortArray = [3,4,5,10,1,2]
sortArray.sort()
print(sortArray)

var sampleString = "ssac"
sampleString.append(": iOS 앱 개발자 데뷔 과정")
print(sampleString)

var sampleString2 = "ssac"
sampleString2.appending(": iOS 앱 개발자 데뷔 과정")
print(sampleString2)

// key는 고유해야한다, 배열과 달리 순서가 없다.(실행할때마다 순서가 다르게 출력된다)
var dictionary : Dictionary<Int, String> = [1 : "철수",2:"영희",3:"코코종"]
print(dictionary)

dictionary[5] = "쨔냐"
print(dictionary)
dictionary[2] // index 가 아닌 key

// 신조어 검색기
let wordDictionary = ["jmt" : "존맛탱","별다줄":"별걸 다 줄인다","스드메":"스튜디오 드레스 메이크업"]
let userSearchText = "별다줄"
wordDictionary[userSearchText]
let userSearchText2 = "JMt"
wordDictionary[userSearchText2.lowercased()]

//let wordArray = ["jmt", "별다줄","스드메"]
//let userText = wordArray.randomElement()!
//if userText == "jmt"{
//    print("존맛탱")
//} else if userText == "별다줄"{
//    print("별걸 다 줄인다")
//}

// 집합 (set), 이것도 순서가 없다.
let set : Set<Int> = [1,1,2,5,6,6,7,8]
let set2 : Set<Int> = [1,2,2,3,4]
set.intersection(set2) // 교집합
print(set)





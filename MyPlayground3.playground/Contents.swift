import UIKit

// 옵셔널 바인딩 : if let , guard

enum UserMissionStatus : String {
    case missionFailed = "실패"
    case missionSucceed = "성공"
    
}

UserMissionStatus.missionFailed.rawValue

func checkNumber(number : Int?) -> (UserMissionStatus, Int?) {
    if number != nil {
        return (.missionSucceed, number!)
    } else {
        return (.missionFailed, nil)
    }
}

func checkNumber2(number : Int?) -> (UserMissionStatus, Int?) {
    if let value = number {
        return (.missionSucceed, value)
    } else {
        return (.missionFailed, nil)
    }
}

func checkNumber3(number : Int?) -> (UserMissionStatus, Int?) {
    guard let value = number else {
        return (.missionFailed, nil)
    }
    
    return (.missionSucceed,value)
}




// 타입 캐스팅 : 메모리의 인스턴스 타입은 바뀌지 않는게 중요함!(메모리 자체에서 바뀌지 않음)
//let array : [Any] = [1,true,"hi"]
//let arraryInt = array as? [Int]

class Mobile {
    let name : String
    
    init(name : String){
        self.name = name
        
    }
}

class AppleMobile : Mobile {
    var company = "Apple"
}

class GoogleMobile : Mobile {
    
}

let mobile = Mobile(name: "PHONE")
let apple = AppleMobile(name: "iPHONE") // 부모클래스의 초기화
let google = GoogleMobile(name: "Galaxy")

mobile is Mobile
mobile is AppleMobile
mobile is GoogleMobile

apple is Mobile
apple is AppleMobile
apple is GoogleMobile

let iPhone : Mobile = AppleMobile(name: "iPad")
iPhone.name

let test = AppleMobile(name: "iPad")
test.company

iPhone as? AppleMobile // 타입캐스티응ㄹ 해도 되는지 물어봄

// as as! as?에 대해 더 알아보기
if let value = iPhone as? AppleMobile {
    print("성공", value.company)
}




// 클래스, 구조체
enum DrinkSize {
    case short,tall, grande, venti
}

struct DrinkStruct {
    let name : String
    var count : Int
    var size : DrinkSize
}

class DrinkClass {
    let name : String
    var count : Int
    var size : DrinkSize
    
    // class는 init이 필수
    init(name : String, count : Int, size : DrinkSize){
        self.name = name
        self.count = count
        self.size = size
    }
}

// let으로 하면 오류(값을 바꾸는것이라서 let으로는 사용x), struct는 원본을 바꿀수 없음
var drinkStruct = DrinkStruct(name: "아아", count: 3, size: .tall)
drinkStruct.count = 2
drinkStruct.size = .grande
print(drinkStruct.name, drinkStruct.count, drinkStruct.size)

let drinkClass = DrinkClass(name: "스무디", count: 2, size: .venti)
drinkClass.count = 5
drinkClass.size = .tall

print(drinkClass.name, drinkClass.count, drinkClass.size)

// 지연 저장 프로퍼티(저장을 지연시킴) : 변수 저장 프로퍼티, 초기화
struct Poster {
    var image : UIImage = UIImage(systemName: "star") ?? UIImage()
    
    init() {
        print("Postser init")
    }
}

struct MediaInfo {
    var mediaTitle : String
    var mediaRuntime : Int
    lazy var mediaPoster : Poster = Poster()
}

var media = MediaInfo(mediaTitle: "오징어게임", mediaRuntime: 333)
print("1")
media.mediaPoster // 이때 비로소 초기화가 된다.
print("2")





// 연산 프로퍼티 & 프로퍼티 감시자 => swift 5.1 propertywrapper (@Enviroment)
// 타입 알리어스
class BMI {
    typealias BMIValue = Double
    
    // 감시자
    var userName : String {
        willSet {
            print("닉네임 바뀔 예정: \(userName) -> \(newValue)")
        }
        didSet {
            print("닉네임 바뀜 : \(oldValue) -> \(userName)")
            changeNameCount += 1
        }
    }
    
    var changeNameCount = 0
    
    var userWeight : BMIValue
    var userHeight : BMIValue
   
    
    var BMIResult : String{
        get {  // 달라고 요청
            let bmiValue = (userHeight * userWeight) / userHeight
            let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상 이상"
            
            return "\(userName)님의 bmi지수는 \(bmiValue)로, \(bmiStatus)입니다"
        }
        
        set(nickname) { // 저장 프로퍼티 string인것을 알아서 매개변수명만 적으면 된다.
            userName = nickname
        }
    }
    
    
    init(userWeight : Double, userHeight : Double, userName : String){
        self.userWeight = userWeight
        self.userHeight = userHeight
        self.userName = userName
    }
}

let bmi = BMI(userWeight: 60, userHeight: 160, userName: "kokojong")
let result = bmi.BMIResult

print(result)
bmi.BMIResult = "MINSU"
bmi.BMIResult = "K"
bmi.BMIResult = "KK"

print(bmi.BMIResult)
print(bmi.changeNameCount)


class User {
    let nickname = "koko"
    
    static let nickname2 = "koko 2"
    // 모든 코드에서 공통적일때 사용
    
    static var totalOrderCount = 0 {
        didSet{
            print("총 주문 횟수: \(oldValue) -> \(totalOrderCount)")
        }
    }
    
    static var orderProduct : Int {
        get {
            return totalOrderCount
        }
        
        set {
            totalOrderCount += newValue
        }
    }
    
}
//
//let user = User()
//user.nickname
//User.nickname2

User.nickname2
User.totalOrderCount
User.orderProduct

User.orderProduct = 10
User.totalOrderCount
User.orderProduct = 20
User.totalOrderCount




struct Point {
    var x = 0.0
    var y = 0.0
    
    mutating func moveBy(x: Double, y: Double){ // mutating : 자신의 값을 바꿀때(struct)
        self.x += x
        self.y += y
    }
    
}

var somePoint = Point()
print("POINT : \(somePoint.x), \(somePoint.y)")
somePoint.moveBy(x: 3.0, y: 5.0)
print("POINT : \(somePoint.x), \(somePoint.y)")


class Coffee {
    static var name = "아메리카노"
    static var shot = 2
    
    static func plusShot() { // 상속을 해도 재정의가 불가능
        shot += 1
    }

    class func minusShot(){ // 상속을 해서 재정의가 가능
        shot -= 1
    }
    
    func hello(){
        
    }
}


Coffee.plusShot()

class Latte : Coffee {
    override class func minusShot() {
        print("타입 메소드를 상속받아서 재정의 하고싶을 경우, 부모 클래스에서 타입 메서드를 선언할 때 static이 아니라 class를 쓰면 재정의 할 수 있다")
    }
}

// property wrapper - 이걸 더 간단하게 쓰려고 만들어짐
class UserDefaultsHelper {
    
    static let shared = UserDefaultsHelper()
    
    let userDefaults = UserDefaults.standard
    
    enum Key : String {
        case nickname, age, rate
    }
    
    var userNickname : String?{
        get{
            return userDefaults.string(forKey: Key.nickname.rawValue)
        }
        set{
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var userAge : Int? {
        get{
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set{
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
    
}

UserDefaultsHelper.shared.userNickname
UserDefaultsHelper.shared.userAge

UserDefaultsHelper.shared.userNickname = "고고"
UserDefaultsHelper.shared.userAge = 15

UserDefaultsHelper.shared.userNickname
UserDefaultsHelper.shared.userAge

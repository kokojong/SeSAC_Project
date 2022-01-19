import UIKit

// 클래스가 인스턴스로 되기 위해서는 클래스의 프로퍼티가 모두 초기화가 되어있어야 한다.(nil x)
// 해결책 : optional 타입으로 만들어준다. -> 컴파일 오류는 발생하지 않지만 런타임 오류가 발생할 수 있따.
// 그렇다고 모두 쓸데없는 값으로 초기화 해버리면 나중에 알아보기 힘들다
// 프로퍼티를 초기화를 위해 빈 괄호를 사용하는 것이 아닌, 초기호 구문을 통해 인자값을 넣어서 프로퍼티를 초기화합니다.

// 구조체는 클래스와 달리 초기화 구성을 제공해준다. -> 멤버 와이즈 초기화 구문
class Monster {
    var clothes : String
    var speed : Int
    var power : Int
    var expoint : Double
    
    // 초기화 구문
    init(clothes : String, speed : Int, power : Int, expoint : Double){
        self.clothes = clothes
        self.speed = speed
        self.power = power
        self.expoint = expoint
        
    }
    
    func attack(){
        print("공 격!")
    }
}

// easyMonster : 인스턴스 (실제화 된 것?)
var easyMonster = Monster(clothes: "orange", speed: 1, power: 10, expoint: 50.0)
easyMonster.clothes
easyMonster.speed
easyMonster.power
easyMonster.expoint

var hardMonster = Monster(clothes: "blue", speed: 10, power: 500, expoint: 10000)
hardMonster.clothes
hardMonster.speed
hardMonster.power
hardMonster.expoint

// 클래스는 상속이 가능하다. -> 기존에 가지고 있던 monster의 요소들을 사용이 가능하다
// Monster : 부모클래스(superClass), BossMonster : 자식클래스(subClass)
class BossMonster : Monster {
    var bossName = "내가 보스"
    
    // 상위 클래스인 Monster의 func을 재정의한다.(여기서만) -> 이것이 override
    override func attack() {
        super.attack() // 부모의 attack도 실행 해주세요~
        print("보스의 공격!")
    }
    
}

var boss = BossMonster(clothes: "black", speed: 100, power: 5000, expoint: 100000)
boss.bossName
boss.clothes
boss.speed
boss.power
boss.expoint
boss.attack()


// 구조체(value 타입) vs reference 타입

var nickname : String = "고래밥"
var subNickname = nickname

nickname = "칙촉"
print(nickname) // 칙촉
print(subNickname) // 고래밥
// 구조체의 value타입을 갖는다.

class SuperBoss {
    var name : String
    var level : Int
    var power : Int
    
    init(name : String, level : Int, power : Int){
        self.name = name
        self.level = level
        self.power = power
        
    }
}

// class의 경우 easystepBoss도 hardstepBoss로 덮어쓰기?가 된다.
// class는 같은 주소값을 저장하게 된다 -> 그래서 원본을 바꾸게 되면 사본도 똑같이 바뀐다.
var hardStepBoss = SuperBoss(name: "쉬운 보스", level: 1, power: 10)

var easyStepBoss = hardStepBoss

hardStepBoss.power = 60000
hardStepBoss.level = 100
hardStepBoss.name = "어려운 보스"

print(hardStepBoss.name, hardStepBoss.level, hardStepBoss.power)
print(easyStepBoss.name, easyStepBoss.level, easyStepBoss.power)


// 10.08(금)
// 함수 매개변수 반환값

// 매개변수를 사용하지 않는 함수
func sayHello() -> String {
    print("안녕하세요!")
    return "안녕"
}
print("자기소개 : \(sayHello()) ")

func bmi() -> Double {
    
    // 조건문
    
    return 20.1
}

func bmiResult() -> [String] {
    
    let name = "코코종"
    let result = "정상"
    return[name,result]
}
let value = bmiResult()
print(value[0] + "님은 " + value[1] + "입니다")


// 컬렉션(집단 자료형) : 배열, 딕셔너리, 집합 + 튜플

let userInfo : (String, String, Bool, Double) = ("kokojong","kokojong@a.com",true, 173.2)
print(userInfo.0) // [0]이 아니라 .0 으로 사용

// 전체 영화의 갯수, 전체 러닝타임을 가져오고 싶다
func getMoviewReport() -> (Int, Int) {
    
    return (1000, 30000)
}

// swift 5.1 return 키워드를 생략 가능 (단순히 리턴할 때)
//func getMoviewReport() -> (Int, Int) {
//    (1000, 30000)
//}

// @discarableResult
// 반환값이 있지만 사용하지 않는다면

// 열거형의 사용
enum AppleDevice {
    case iPhone
    case iPad
    case watch
}

enum GameJob : String {
    case rogue = "도적"
    case warrior = "전사"
    case mystic = "도사"
    case shaman = "주술사"
    case fight = "격투가"
}

let selectJob : GameJob = GameJob.mystic

if selectJob == GameJob.mystic{
//    print("도사")
} else if selectJob == GameJob.rogue{
    print("도적")
}

print("당신은 \(selectJob.rawValue) 입니다") // 더 편하게

enum Gender {
    case man, woman
}

enum HTTPCode : Int { // 변수처럼 사용
    // 변수를 초기화 하지 않는다면 index가 기입된다 0, 1, 2
    // 몇개는 하고 몇개는 안한다면 안한값은 초기화 한 값 +1 으로 순차적으로 기입
    case OK = 200
    case SERVER_ERROR = 500
    case SERVER_ERROR2 // 501
    case NO_PAGE = 400
    
    func showStatus () -> String {
        
        switch self {
        case .NO_PAGE :
            return "잘못된 주소입니다"
        case .SERVER_ERROR:
            return "서버 오류입니다"
        case .OK :
            return "정상입니다"
        case .SERVER_ERROR2 :
            return "서버 오류입니다2"
        }
    }
}

var status : HTTPCode = .OK

print(status.rawValue) // 원시값

status.showStatus() // 내부 함수를 실행



//
if status == .NO_PAGE{
    print("잘못된 주소입니다")
} else if status == .SERVER_ERROR{
    print("서버 오류입니다")
}


//
func sayHi ()->String {
    let hi = "hi"
    return hi
}

func login () -> (Int, String) {
    return (100,"hi")
}

//guard let
func printName(){
  var value:String?
  value = nil
  print(value) // Optional("Lena")
  guard let name = value else { return }
  print(name) // "Lena"
  //name변수는 메소드 내에서 지역상수처럼 사용 가능.
}

printName()

import UIKit
// 프로토콜 : 클래스, 구조체의 청사진?
// 프로토콜은 실질적인 구현은 하지 않고 명세만 해준다.
// 특정 뷰 객체

// 프로토콜 메서드

// 만약 프로토콜을 클래스에서만 사용하게 제한한다면? AnyObject
protocol OrderSystem : AnyObject {
    func recommandEventMenu() // 실질적인 구현x
    func askStampACard(count : Int) -> String
    
//    init()
    // 초기화 구문. 구조체가 멤버와이즈 구문이 있더라도 프로토콜에 구현되어 있따면 필수!!로 구현해야함
    // 클래스의 경우, 부모 클래스에 초기화 구문과 프로토콜의 초기화 구문이 구별되게 명시해야 한다. (required init)
}

class StarBucksMenu {
    
}
// class는 단일 상속 밖에 되지 않는다 -> 다른것을 사용하려면 프로토콜을 사용하기
class Smoothie : StarBucksMenu,OrderSystem {
    func recommandEventMenu() {
        print("스무디 이벤트 안내")
    }
    
    func askStampACard(count: Int) -> String {
        return "\(count)잔 적립 완료"
    }
    
}

class Coffee : StarBucksMenu, OrderSystem {
    
    let smoothie = Smoothie()
    func test(){
        smoothie is Coffee // false
        smoothie is StarBucksMenu // true
        smoothie is OrderSystem // true
        // 상속 받은 프로토콜로 형변환이 가능하다. -> tableview.delegate = self 하는 부분
    }
 
    func recommandEventMenu() {
        print("커피 이벤트 안내")
    }
    
    func askStampACard(count: Int) -> String {
        return "\(count * 2)잔 적립 완료"
    }
    
    
}

// 프로토콜 프로퍼티 : 타입과 get, set만 명시, 연산 프로퍼티/저장 프로퍼티는 상관없음
protocol NavigationUIProtocol {
    var titleString : String { get set  } // 읽기 쓰기 모두 사용할 수 있게함
    var mainTintColor : UIColor { get } // 읽기만 가능
    
}

class KojongViewController : UIViewController , NavigationUIProtocol {
    
    // 초기화
    var titleString: String = "졸리다.."
    var mainTintColor: UIColor = .black // get만 하기로 했는데?
    // get만 사용한 경우 -> get는 필수, set은 선택(둘다 가능하다)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleString
        view.backgroundColor = mainTintColor
        
        
    }
    
}

class Kojong2ViewController : UIViewController, NavigationUIProtocol {
    var titleString: String {
        get {
            return "일기"
        }
        set{
            title = newValue
        }
    }
    
    var mainTintColor: UIColor {
        get {
            return .blue // get은 필수
        }
        set {
            // set은 선택
        }
        // get만 쓴다면 축약이 가능
//        return .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleString = "새 일기" // set
    }
    
}

// 연산 프로퍼티 연습
struct SeSACStudent {
    
    var totalCount = 50
    
    var currentStudent = 0
    
    var studentUpdate : String {
        get {
            return "정원 마감까지 \(totalCount - currentStudent)명 남았습니다."
        }
        set {
            currentStudent += Int(newValue)!
        }
    }
}


var sesac = SeSACStudent()
sesac.studentUpdate = "10"
print(sesac.studentUpdate)

import UIKit

// 사용자들, 그룹, 길드, 길드장

class Guild {
    
    var guildName: String
    
//    weak var guildMaster: User? // weak를 주면 rc가 올라가지 않음
    // 인스턴스 참조시에 RC를 증가시키지 않음
    
    unowned var guildMaster: User? // unowned (미소유 참조)
    // 얘도 인스턴스 참조시에 RC를 증가시키지 않음
    
    init(guildName: String) {
        self.guildName = guildName
        print("Guild init")
    }
    
    deinit {
        print("Guild deinit")
    }
    
    
}



class User {
    
    var userName: String
    
    var guild: Guild?
    
    init(userName: String) {
        self.userName = userName
        print("User init")
    }
    
    deinit {
        print("User deinit")
    }
    
}

var sesac: Guild? = Guild(guildName: "sesac") // reference count + 1
//sesac = nil // deinit 시킴

var userName: User? = User(userName: "코코종")
//userName = nil // deinit - reference count - 1

sesac?.guildMaster = userName // RC 2
userName?.guild = sesac // RC 2

//sesac?.guildMaster
//userName?.guild

//sesac?.guildMaster = nil // 하나만 끊어줘도 2개가 끊어짐(순환참조를 벗어남)


userName = nil
//sesac = nil

// RC가 -1이 되어서 nil이 되어도 deinit이 되지 않는다
// 순환참조!

sesac?.guildMaster
// unowned 로 한 경우에는 nil이 되어도 그것에 대한 주소는 가지고 있다(주소는 있는데 실제로는 없음 -> 에러 발생)
// 이런 오류 때문에 자주 사용하지 않음
// error: Execution was interrupted, reason: signal SIGABRT.
// The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.

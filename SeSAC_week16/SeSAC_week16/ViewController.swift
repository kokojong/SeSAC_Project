//
//  ViewController.swift
//  SeSAC_week16
//
//  Created by kokojong on 2022/01/10.
//

import UIKit

// class에서만
protocol myProtocol: AnyObject {
    
}

enum GameJob {
    case warrior
    case rogue
}

class Game {
    var level = 5
    var name = "도사"
    var job = GameJob.warrior
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        copyOnWrite()
//        aboutSubscript()
//        aboutForEach()
        aboutEnum()
        
    }
    @IBAction func btn(_ sender: Any) {
//        print(sender.currentTitle)
        view.endEditing(true)
    }
    
    @IBAction func txtField(_ sender: Any) {
        // 같은 동작을 button 과 textField에 둘다 적용하려면 -> Any로 연결
        view.endEditing(true)
    }
    
    // AnyObjct vc Any
    // 런타임 시점에 타입이 결정 -> 런타임 오류의 가능성
    // 컴파일 시점에서 알 수 없음
    // Any: Class, Struct, Enum, Closure ...
    // AnyObject: Class
    
    func aboutAnyObject() {
        
        let name = "kokojong"
        let gender = true
        let age = 29
        let characters = Game()
        
        let anyList: [Any] = [name, gender, age, characters]
        
        let anyObjectList: [AnyObject] = [characters]
        print(anyList, anyObjectList)
        
        if let val = anyList[0] as? String {
            print(val)
        }
    }
    
    // COW
    func copyOnWrite() {
        
        // Struct -> 값을 복사(메모리가 다름)
//        var nickname = "kokojong"
//
//        var nicknameByFamily = nickname
//
//        nicknameByFamily = "쫑"
//
//        print(nickname,nicknameByFamily)
//        print(address(of: nickname), address(of: nicknameByFamily))
        
        // 수정되기 전까지는 원본을 공유 (내용이 바뀌면)-> 복사 (collection type에서 일어남)
        var arr = Array(repeating: 100, count: 100)
        print(address(of: &arr))
        // 여기까지는 동일한 메모리
        var newArr = arr
        print(address(of: &newArr))
        // 여기서 다른 메모리 주소로 옮겨간다
        newArr[0] = 0
        print(address(of: &newArr))
        
        
        // Class
        var game = Game()
        
        var newGame = game

        newGame.level = 10
        // 똑같이 바뀌어버린다 why? 같은 메모리를 참조하기 떄문(참조타입)
        print(game.level, newGame.level)
        
    }
    
    func address(of object: UnsafeRawPointer) -> String {
        let add = Int(bitPattern: object)
        return String(format: "%p", add)
    }
    
    
    // Collection type : Collection, Sequence, Subscript
    func aboutSubscript() {
        
        let arr = [1,2,3,4,5]
        arr[2] // 3
        
        let dic = ["코종": 29, "사라": 24]
        dic["코종"] // 29
        
        let str = "Hello World"
//        str[2] // 불가능(collection이 아니라서 subscript를 사용 불가)
        // extension 해서 가능
        print(str[2], str[8])
        
        //
        struct UserPhone {
            var numbers = ["01051117479","01051117471","01051117472"]
            subscript(idx: Int) -> String {
                get {
                    return self.numbers[idx]
                }
                set {
                    self.numbers[idx] = newValue
                }
            }
            
        }
        var value = UserPhone()
//        value[0] 원래는 불가능 -> subscript를 추가해주면 가능
        print(value[0])
        value[1] = "12345"
        print(value[1])
        
    }
    
    func aboutForEach() {
        
        // break, coutinue (흐름 제어)
        let arr = [1,2,3,4,5]
        for i in arr {
//            if i == 4 {
//                break // return 처럼 동작
//            }
            print(i)
            return // 바로 리턴해서 다음꺼 실행x
        }
        
        // forEach는 특정조건에 따른게 불가(break, continue가 불가)
        arr.forEach { i in
            print(i)
            return // 리턴이 의미가 없음
        }
        
        
    }
    
    // 라이브러리, 프레임워크에서 도움된다
    // @frozen: 4.2에서 추가된 것, 컴파일시에 유용(최적화 시에)
    // Unfrozen Enumaration: 계속 추가될 수 있는 가능성을 가진 열거형
    // @unknown: default
    func aboutEnum() {
        
//        let size = UIUserInterfaceSizeClass.compact
//        switch size {
//        case .unspecified:
//            <#code#>
//        case .compact:
//            <#code#>
//        case .regular:
//            <#code#>
//        @unknown default:
//            <#fatalError()#>
//        }
        
    }

}

// string에서도 index에 접근가능 하도록 하는 extension
extension String {
    subscript(idx: Int) -> String? {
        get {
            guard (0..<count).contains(idx) else {
                return nil
            }
            let result = index(startIndex, offsetBy: idx)
            return String(self[result])
                    
        }
        
    }
    
}

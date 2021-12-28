//
//  TempViewController.swift
//  SeSAC_week13
//
//  Created by kokojong on 2021/12/24.
//

import UIKit

// shift + ctrl + 클릭 - 여러 라인 동시 선택
// opt + cmd + [ or ] - 해당 라인 바꾸기(다른 라인과 교체)
// 자동완성 부분에서 마우스로 블록 크기를 크게 할 수 있다
// ctrl + cmd + 위 - internal 같은 거를 나오게 보여주기(닫으려면 아래) (interface)
// opt + cmd + 좌우 - 중괄호 닫기 열기
// ctrl + I - 들여쓰기 자동...(미쳐따)
// opt + cmd + L - 커서 위치 찾기
// mark를 통해서 minimap에서 바로 볼 수 있다(미니맵에서 cmd 누르면 함수 다 나옴)
// shift + cmd + O - 파일 바로 열기
// 마크업 사용 (///)
// opt + cmd + / - 마크업 시에 자동으로 매개변수를 적어주기

// 시뮬레이터에서 debug -> color blended layer
// slow animation


// MARK: TEST

class TempViewController: UIViewController {
    
    var arr = [1,2,3]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var mycountryName = "as"
        
        
        print(#function)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    /// 옵션 커맨드 슬래시
    /// - Parameter animated: 애니매이션 여뷰
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    /// - parameter message: 애배배ㅐㅂ
    /// - important: asdfsadf
    /// - returns : 리리턴턴
    /// - 으어
    ///     - 아니이 *기울임*이 된다고? **볼드**도 된다고?
    ///     - [이동하기](https://www.naver.com)
    ///
    func welcome(message: String) -> String {
        return ""
        
    }


}

class User {
    
    var name: String
    var age: Int
    var email: String
    
    
    internal init(name: String, age: Int, email: String) {
        self.name = name
        self.age = age
        self.email = email
    }
    
    
}

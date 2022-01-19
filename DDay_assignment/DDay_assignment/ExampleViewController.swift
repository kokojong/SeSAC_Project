//
//  ExampleViewController.swift
//  DDay_assignment
//
//  Created by kokojong on 2021/10/08.
//

import UIKit
enum GameJob {
    case rogue, warrior, mystic, shaman, fight
}

let userNotificationCenter = UNUserNotificationCenter.current()
//let ud = UserDefaults.standard

class ExampleViewController: UIViewController {
    
    var selectJob : GameJob = .rogue

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = setViewBackground()
        setViewBackground() // discardable
        
//        switch selectJob {
//        case .rogue:
//            <#code#>
//        case .warrior:
//            <#code#>
//        case .mystic:
//            <#code#>
//        case .shaman:
//            <#code#>
//        case .fight:
//            <#code#>
//        } // 열거형의 경우 모든 케이스를 다 적어준다면 디폴트를 생략 가능
        
        requestNotiAuthorization()
    }
    
    // 1. 반환값의 타입을 옵셔널 타입으로 변경 : UIColor -> UIColor?
    // 2. 반환될 값을 강제로 해제 random.randomElement()!
    // 3. 반환될 값 : ?? (if else 처럼)
    
    
    @IBAction func showAlert(_ sender: UIButton) {
        
        // 1. UIAlertController 생성 : 밑바탕 + 타이틀 + 본문
        let alert = UIAlertController(title: "타이틀 텍스트", message: "메세지", preferredStyle: .alert)
        // 2. UIAlertAction 생성 : 버튼들을 만들어준다
        let ok = UIAlertAction(title: "아이폰 겟", style: .default)
        let ipad = UIAlertAction(title: "아이패드", style: .cancel)
        let watch = UIAlertAction(title: "와치", style: .destructive)
        
        // 3. 1과 2를 합쳐준다
        // addAction의 순서대로 버튼이 붙는다
        alert.addAction(ok)
        alert.addAction(ipad)
        alert.addAction(watch)
        
        // 4. Present (보여줌) - modal처럼
        present(alert, animated: true, completion: nil)
        
    
        // 컬러피커
//        let colorPicker = UIColorPickerViewController()
//        present(colorPicker, animated: true, completion: nil)
        
    }
    
    func requestNotiAuthorization (){
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if success {
                self.sendNotification()
            }
        }
    }
    

    func sendNotification(){
        // 어떤 정보를 보낼지 컨텐츠 구성
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "물 마실 시간이에요!"
        notificationContent.body = "하루 2리터 목표 달성을 위해 열심히 달려보아요"
        notificationContent.badge = 100
     
        // 언제 보낼지를 설정 : 1. 시간 간격, 2. 캘린더, 3. 위치 에 따라서 설정이 가능
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        // 반복을 하려면 최소 60s
        
        // 알림을 요청
        let request = UNNotificationRequest(identifier: "\(Date())",
                                            content: notificationContent,
                                            trigger: trigger)

        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    
    
    @discardableResult // return 값을 써도되고 안써도 되고
    func setViewBackground() -> UIColor {
        let random : [UIColor] = [.red,.black, .gray, .green]
//        return random.randomElement()! // 오류가 뜬다.optional -> !로 nil이 될 수 없음을 명시
        return random.randomElement() ?? UIColor.yellow // 3번 방식
    }
    

 

}

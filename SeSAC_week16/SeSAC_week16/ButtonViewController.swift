//
//  ButtonViewController.swift
//  SeSAC_week16
//
//  Created by kokojong on 2022/01/13.
//

import UIKit

//print("before class") // top level - 함수나 클래스만 가능

class ButtonViewController: UIViewController, UIColorPickerViewControllerDelegate {

    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        button.center = view.center
        button.configurationUpdateHandler = { btn in
            if btn.isHighlighted {
//                btn.backgroundColor = .green
                btn.configuration?.baseForegroundColor = .blue
            }
            
        }
        
        view.addSubview(button)
        
        button.configuration = .kokojongButton()
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        
//        dateFormatStyle()
//        numberFormatStyle()
        print(deferExample())
        print(deferExample2())
        deferExample3()
    }
    
    func deferExample() -> String {
        
        var nickname = "kokojong"
        
        defer { // 스코프의 끝에서 실행된다 -> 함수에서 리소스 정리 할 때 사용
            nickname = "sarah"
            print("defer")
        }
        
        return nickname
    }
    
    func deferExample2() -> String? {
        var nickname: String? = "kokojong2"
        
        defer {
            nickname = nil
        }
        
        return nickname
    }
    
    func deferExample3() { // 여러개 -> 뒤에 있는게 먼저
        
        defer {
            print("1")
        }
        
        defer {
            print("2")
        }
        
        // 내부에 넣으면 바깥부터 (3 -> 4)
        defer {
            print("3")
            defer{
                print("4")
            }
        }
        
    }
    
    func dateFormatStyle() {
        
        let value = Date()
        print(value)
        print(value.formatted())
        print(value.formatted(date: .complete, time: .shortened))
        
        let locale = Locale(identifier: "ko-KR")
        
        let result = value.formatted(.dateTime.locale(locale).day().month(.twoDigits).year())
        print(result)
        let result2 = value.formatted(.dateTime.day().month().year())
        print(result2)
        
    }
    
    func numberFormatStyle() {
        
        print(50.formatted(.percent))
        print(123125125.formatted())
        print(345987234.formatted(.currency(code: "krw")))
    
        let result = ["ㅇㅇㅇ","ㅁㅁㅁㅁ","ㄴㄴㄴㄴ"].formatted()
        print(result)
    
    }
    
    
    @objc func buttonClicked() {
        
        let vc = ChatViewController()
        
        
        // 다음 뷰컨에 선언해도 된다(취향따라)
        if let presentationVC = vc.presentationController as? UISheetPresentationController {
            presentationVC.detents = [.medium(), .large()]
            presentationVC.prefersGrabberVisible = true
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    @objc func buttonClicked2() {
     
        let picker = UIColorPickerViewController()
        picker.delegate = self
        
        if let presentationController = picker.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
            presentationController.prefersGrabberVisible = true
            presentationController.preferredCornerRadius = 20
            
        }
        
        present(picker, animated: true, completion: nil)
        
        
    }
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.animateChanges {
                presentationController.selectedDetentIdentifier = .medium
            }
            
        }
        
        view.backgroundColor = color
    }
    
    
    

  

}

extension UIButton.Configuration {
    
    static func kokojongButton() -> UIButton.Configuration {
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "kokojong"
        configuration.subtitle = "koko"
        configuration.titleAlignment = .trailing
        configuration.baseForegroundColor = .red
        configuration.baseBackgroundColor = .yellow
        configuration.image = UIImage(systemName: "star")
        configuration.imagePlacement = .trailing
        configuration.cornerStyle = .capsule
        configuration.titlePadding = 10
        configuration.imagePadding = 15
        configuration.showsActivityIndicator = true
        return configuration
        
    }
    
}

//
//  AsyncViewController.swift
//  SeSAC_week5_network
//
//  Created by kokojong on 2021/10/29.
//

import UIKit

class AsyncViewController: UIViewController {
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var seg: UISegmentedControl!
    @IBOutlet weak var mainSwitch: UISwitch!
    
    @IBOutlet var collectionLabel: [UILabel]!
    
    let url = "https://images.pexels.com/photos/3791466/pexels-photo-3791466.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. 내일 날짜 구하기 -> 어제는 직접 해보기 -> 영화진흥원
        let calendarDate = Calendar.current
        let tomorrow = calendarDate.date(byAdding: .day , value: 1, to: Date() )
        // Date는 영국시간 기준이기 때문에 dateFormatter를 사용하면 한국기준으로 가능
        print(tomorrow)
        
        // 2. 이번주 월요일 -> 로또 부분
        var component = calendarDate.dateComponents([.weekOfYear, .yearForWeekOfYear, .weekday], from: Date())
        component.weekday = 2 // 6이 금요일
        
        let mondayWeek = calendarDate.date(from: component)
        print(mondayWeek)
    
        for i in collectionLabel {
            i.backgroundColor = .blue
        }
        
        collectionLabel.forEach {
            $0.backgroundColor = .red
            $0.clipsToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.white.cgColor
        }
        
        // extension을 이용한 축약
        collectionLabel.forEach { $0.setBorder() }
        
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
    
        // 다른 쓰레드에 비동기처리를 하기 위해 큐를 보냄
        DispatchQueue.global().async {
            if let url = URL(string: self.url), let data = try? Data(contentsOf: url), let image = UIImage(data: data){
//                self.mainImageView.image = image // 메인 쓰레드 오류
            
                DispatchQueue.main.async {
                    self.mainImageView.image = image
                }
            }
        }
        
        
    }
    
}

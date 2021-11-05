//
//  CalendarViewController.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    
    @IBOutlet weak var allCountLabel: UILabel!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("calendarTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
     
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        tasks = localRealm.objects(UserDiary.self)
        
//        let allCount = localRealm.objects(UserDiary.self).count
        let allCount = getAlldiaryCount()
        allCountLabel.text = "총 \(allCount)개"
        
        let recent =  localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate").first?.diaryTitle
//        let old = localRealm.objects(UserDiary.self).
        print(recent)
        
//        let full = localRealm.objects(UserDiary.self).filter("diaryTitle != nil").count
//        print(full)
    
//        let favorite = localRealm.objects(UserDiary.self).filter("")
        
//        let search = localRealm.objects(UserDiary.self).filter("diaryTitle == '1' AND diaryContent == '일기 내용'")
//        print(search)
//
        
    }
    
    
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "title"
//    }
//
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        return "subtitle"
//
//    }
//
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//      return UIImage(systemName: "person")
//    }
    
    // Date: 시 분 초가 모두 동일해야 한다
    // 1. 영국 표준 시간 기준으로 표기하기 2021-11-27 15:00 -> 20211128
    // 2. DateFormatter를 사용
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        // 11.2일에 3개의 일기라면 3개를, 없다면 점을 안찍기, 한개만 썼으면 한개만 찍기
        
        return tasks.filter("diaryDate == %@", date).count
        
        
        
//        let format = DateFormatter()
//        format.dateFormat = "yyyyMMdd"
//        let test = "20211103"
//
//        if format.date(from: test) == date {
//            return 5
//        } else {
//            return 1
//        }
     
        
        
    }
    
    
    
}

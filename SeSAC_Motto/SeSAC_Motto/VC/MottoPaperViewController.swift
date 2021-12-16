//
//  LottoPaperViewController.swift
//  SeSAC_Motto
//
//  Created by kokojong on 2021/11/23.
//

import UIKit
import RealmSwift
import Toast

class MottoPaperViewController: UIViewController {
    
    static let identifier = "MottoPaperViewController"
    
    @IBOutlet weak var drawNoLabel: UILabel!
    @IBOutlet weak var nextDrawDateLabel: UILabel!
    @IBOutlet weak var mottoPaperBuyDateLabel: UILabel!
    
    @IBOutlet weak var aNumberStackView: UIStackView!
    @IBOutlet weak var bNumberStackView: UIStackView!
    @IBOutlet weak var cNumberStackView: UIStackView!
    @IBOutlet weak var dNumberStackView: UIStackView!
    @IBOutlet weak var eNumberStackView: UIStackView!
    
    
    var includedNumberList: [Int] = []
    var exceptedNumberList: [Int] = []
    
    var posibleNumberList: [Int] = [] //
    
    let localRealm = try! Realm()
    
    var mottoPapers: Results<MottoPaper>!
    
    var isMotto: Bool = true
    
    var mottoPaperCount = 0 // 몇번째 paper인지
    
    var mottoPaper: MottoPaper = MottoPaper()
    
    var nextDrawNo = UserDefaults.standard.integer(forKey: "recentDrawNo") + 1 {
        didSet {
            print("nextDrawNo",nextDrawNo)
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.makeToast("자동 모또가 추가되었습니다")
        
        mottoPapers = localRealm.objects(MottoPaper.self)
        
        for i in 1...45 {
            if exceptedNumberList.contains(i) {
                
            } else if includedNumberList.contains(i) {
                
            } else { // 나머지 수
                posibleNumberList.append(i)
            }
        }
        
        var mottoList: [Motto] = []
        for i in 0...4 {
            let resultNumberList = createNumberList()[0...5].sorted()
            let motto =  Motto(mottoDrwNo: nextDrawNo, mottoBuyDate: Date(), mottoDrwtNo1: resultNumberList[0], mottoDrwtNo2: resultNumberList[1], mottoDrwtNo3: resultNumberList[2], mottoDrwtNo4: resultNumberList[3], mottoDrwtNo5: resultNumberList[4], mottoDrwtNo6: resultNumberList[5], mottoNum: i, isMotto: isMotto)
            mottoList.append(motto)
        }
        
        mottoPaper = MottoPaper(mottoPaperDrwNo: nextDrawNo, mottoPaperBuyDate: Date(), mottoPaper: mottoList, mottoPaperNum: mottoPaperCount, isMottoPaper: isMotto)
       
        
        try! localRealm.write{
            localRealm.add(mottoPaper)
        }
        
        updateStackViews(stackView: aNumberStackView, game: 0)
        updateStackViews(stackView: bNumberStackView, game: 1)
        updateStackViews(stackView: cNumberStackView, game: 2)
        updateStackViews(stackView: dNumberStackView, game: 3)
        updateStackViews(stackView: eNumberStackView, game: 4)
//        updateTextOnLabel(label: gameALabel, mottoPaper:
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy.MM.dd"
        mottoPaperBuyDateLabel.text = "\(dateFormatter.string(from: mottoPaper.mottoPaperBuyDate))"
        drawNoLabel.text = "\(mottoPaper.mottoPaperDrwNo)회차"
        
        let recentDrawDateString = UserDefaults.standard.string(forKey: "recentDrawDate") ?? "2021-11-27"
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        dateFormatter2.locale = Locale(identifier: "ko_kr")
        let recentDrawDateDate = dateFormatter2.date(from: recentDrawDateString)
        
        let nextDrawDate = Calendar.current.date(byAdding: .day, value: 7, to: recentDrawDateDate!)
        
        nextDrawDateLabel.text = "\(dateFormatter.string(from: nextDrawDate!))"
    
    }
    

    func createNumberList () -> [Int] {
        
        let resultList = includedNumberList + posibleNumberList.shuffled()
        return resultList
    }
    
    
    func updateStackViews(stackView: UIStackView, game: Int) {
        
        let mottoGame = mottoPaper.mottoPaper[game]
        var index = 1
        for v in stackView.arrangedSubviews {
            let label = v as! UILabel
            label.clipsToBounds = true
            label.layer.cornerRadius = label.layer.frame.size.width / 2
            label.textColor = .white
            
            switch index {
            case 1: label.text = "\(mottoGame.mottoDrwtNo1)"
            case 2: label.text = "\(mottoGame.mottoDrwtNo2)"
            case 3: label.text = "\(mottoGame.mottoDrwtNo3)"
            case 4: label.text = "\(mottoGame.mottoDrwtNo4)"
            case 5: label.text = "\(mottoGame.mottoDrwtNo5)"
            case 6: label.text = "\(mottoGame.mottoDrwtNo6)"
           
            default: // 7번은 +
                print("error")
                
            }
       
            index += 1
        }
    }
}

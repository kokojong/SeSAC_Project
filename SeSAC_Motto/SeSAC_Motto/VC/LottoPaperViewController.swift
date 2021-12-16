//
//  LottoPaperViewController.swift
//  SeSAC_Motto
//
//  Created by kokojong on 2021/11/26.
//

import UIKit
import RealmSwift
import Toast

class LottoPaperViewController: UIViewController {
    
    @IBOutlet weak var drawNoLabel: UILabel!
    
    @IBOutlet weak var aNumberStackView: UIStackView!
    @IBOutlet weak var bNumberStackView: UIStackView!
    @IBOutlet weak var cNumberStackView: UIStackView!
    @IBOutlet weak var dNumberStackView: UIStackView!
    @IBOutlet weak var eNumberStackView: UIStackView!
    
    @IBOutlet weak var BStackView: UIStackView!
    @IBOutlet weak var CStackView: UIStackView!
    @IBOutlet weak var DStackView: UIStackView!
    @IBOutlet weak var EStackView: UIStackView!
    
    @IBOutlet weak var lottoPaperBuyDateLabel: UILabel!
    @IBOutlet weak var nextDrawDateLabel: UILabel!
    static let identifier = "LottoPaperViewController"

    var lottoNumerList: [[Int]] = []
    
    let localRealm = try! Realm()
    
    var lottoPapers: Results<MottoPaper>!
    
//    var lottoPaper: MottoPaper = MottoPaper()
    
    var mottoPaperCount = 0
    
    var isMotto: Bool = false
    
    var nextDrawNo = UserDefaults.standard.integer(forKey: "recentDrawNo") + 1 {
        didSet {
            print("nextDrawNo",nextDrawNo)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.makeToast("수동 모또가 추가되었습니다")
        
        lottoPapers = localRealm.objects(MottoPaper.self)
        
        var lottoList: [Motto] = []
        for i in 0...lottoNumerList.count - 1 {
            let resultNumberList = lottoNumerList[i].sorted()
            let lotto =  Motto(mottoDrwNo: nextDrawNo, mottoBuyDate: Date(), mottoDrwtNo1: resultNumberList[0], mottoDrwtNo2: resultNumberList[1], mottoDrwtNo3: resultNumberList[2], mottoDrwtNo4: resultNumberList[3], mottoDrwtNo5: resultNumberList[4], mottoDrwtNo6: resultNumberList[5], mottoNum: i, isMotto: isMotto)
            lottoList.append(lotto)
        }
        
        let lottoPaper = MottoPaper(mottoPaperDrwNo: nextDrawNo, mottoPaperBuyDate: Date(), mottoPaper: lottoList, mottoPaperNum: mottoPaperCount, isMottoPaper: isMotto)
       
        
        try! localRealm.write{
            localRealm.add(lottoPaper)
        }
        
        drawNoLabel.text = "\(nextDrawNo)"
        
        bNumberStackView.isHidden = true
        cNumberStackView.isHidden = true
        dNumberStackView.isHidden = true
        eNumberStackView.isHidden = true

        BStackView.isHidden = true
        CStackView.isHidden = true
        DStackView.isHidden = true
        EStackView.isHidden = true
        
        if lottoNumerList.count >= 1 {
            updateStackViews(stackView: aNumberStackView, game: 0)
        }
        if lottoNumerList.count >= 2 {
            updateStackViews(stackView: bNumberStackView, game: 1)
            bNumberStackView.isHidden = false
            BStackView.isHidden = false
        }
        if lottoNumerList.count >= 3 {
            updateStackViews(stackView: cNumberStackView, game: 2)
            cNumberStackView.isHidden = false
            CStackView.isHidden = false
        }
        if lottoNumerList.count >= 4 {
            updateStackViews(stackView: dNumberStackView, game: 3)
            dNumberStackView.isHidden = false
            DStackView.isHidden = false
        }
        if lottoNumerList.count >= 5 {
            updateStackViews(stackView: eNumberStackView, game: 4)
            eNumberStackView.isHidden = false
            EStackView.isHidden = false
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy.MM.dd"
        lottoPaperBuyDateLabel.text = "\(dateFormatter.string(from: lottoPaper.mottoPaperBuyDate))"
        
        drawNoLabel.text = "\(lottoPaper.mottoPaperDrwNo)회차"

        let recentDrawDateString = UserDefaults.standard.string(forKey: "recentDrawDate") ?? "2021-11-27"
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        dateFormatter2.locale = Locale(identifier: "ko_kr")
        let recentDrawDateDate = dateFormatter2.date(from: recentDrawDateString)
        
        let nextDrawDate = Calendar.current.date(byAdding: .day, value: 7, to: recentDrawDateDate!)
        
        nextDrawDateLabel.text = "\(dateFormatter.string(from: nextDrawDate!))"
    
    }
    
    func updateTextOnLabel(label: UILabel, lottoPaper: MottoPaper ,game: Int){
        label.text = "\(lottoPaper.mottoPaper[game].mottoDrwtNo1) \(lottoPaper.mottoPaper[game].mottoDrwtNo2) \(lottoPaper.mottoPaper[game].mottoDrwtNo3) \(lottoPaper.mottoPaper[game].mottoDrwtNo4) \(lottoPaper.mottoPaper[game].mottoDrwtNo5) \(lottoPaper.mottoPaper[game].mottoDrwtNo6)"
    }

    func updateStackViews(stackView: UIStackView, game: Int) {
        
//        let mottoGame = lottoPaper.mottoPaper[game]
        var index = 1
        for v in stackView.arrangedSubviews {
            let label = v as! UILabel
            label.clipsToBounds = true
            label.layer.cornerRadius = label.layer.frame.size.width / 2
            label.textColor = .white
            
            switch index {
            case 1: label.text = "\(lottoNumerList[game][0])"
            case 2: label.text = "\(lottoNumerList[game][1])"
            case 3: label.text = "\(lottoNumerList[game][2])"
            case 4: label.text = "\(lottoNumerList[game][3])"
            case 5: label.text = "\(lottoNumerList[game][4])"
            case 6: label.text = "\(lottoNumerList[game][5])"
           
            default: // 7번은 +
                label.textColor = .orange
                label.text = "+"
                
            }
       
            index += 1
        }
    }
  

}

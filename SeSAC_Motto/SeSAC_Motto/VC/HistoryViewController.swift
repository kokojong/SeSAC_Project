//
//  StatisticsViewController.swift
//  SeSAC_Motto
//
//  Created by kokojong on 2021/11/18.
//

import UIKit
import RealmSwift

class HistoryViewController: UIViewController {

    @IBOutlet weak var mottoBuyCountLabel: UILabel!
    @IBOutlet weak var lottoBuyCountLabel: UILabel!
  
    @IBOutlet weak var mottoPrz1CountLabel: UILabel!
    @IBOutlet weak var mottoPrz2CountLabel: UILabel!
    @IBOutlet weak var mottoPrz3CountLabel: UILabel!
    @IBOutlet weak var mottoPrz4CountLabel: UILabel!
    @IBOutlet weak var mottoPrz5CountLabel: UILabel!
    
    @IBOutlet weak var lottoPrz1CountLabel: UILabel!
    @IBOutlet weak var lottoPrz2CountLabel: UILabel!
    @IBOutlet weak var lottoPrz3CountLabel: UILabel!
    @IBOutlet weak var lottoPrz4CountLabel: UILabel!
    @IBOutlet weak var lottoPrz5CountLabel: UILabel!
    
    let localRealm = try! Realm()
    var mottoes: Results<Motto>!
    var lottoes: Results<Motto>!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let mottoPredicate = NSPredicate(format: "isMotto == true")
        mottoes = localRealm.objects(Motto.self).filter(mottoPredicate)
        
        let lottoPredicate = NSPredicate(format: "isMotto == false")
        lottoes = localRealm.objects(Motto.self).filter(lottoPredicate)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        mottoBuyCountLabel.text = "\(numberFormatter.string(for: mottoes.count) ?? "0")" + "게임"
        lottoBuyCountLabel.text = "\(numberFormatter.string(for: lottoes.count) ?? "0")" + "게임"
     
        
        for i in 1...5 {
            let predicate = NSPredicate(format: "prize == %@", NSNumber(integerLiteral: i))
            switch i {
            case 1:
                mottoPrz1CountLabel.text = "\(mottoes.filter(predicate).count)개"
                lottoPrz1CountLabel.text =
                "\(lottoes.filter(predicate).count)개"
            case 2:
                mottoPrz2CountLabel.text = "\(mottoes.filter(predicate).count)개"
                lottoPrz2CountLabel.text =
                "\(lottoes.filter(predicate).count)개"
            case 3:
                mottoPrz3CountLabel.text = "\(mottoes.filter(predicate).count)개"
                lottoPrz3CountLabel.text =
                "\(lottoes.filter(predicate).count)개"
            case 4:
                mottoPrz4CountLabel.text = "\(mottoes.filter(predicate).count)개"
                lottoPrz4CountLabel.text =
                "\(lottoes.filter(predicate).count)개"
            case 5:
                mottoPrz5CountLabel.text = "\(mottoes.filter(predicate).count)개"
                lottoPrz5CountLabel.text =
                "\(lottoes.filter(predicate).count)개"
            default :
                print("error")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "기록 보기"
        
        let mottoPredicate = NSPredicate(format: "isMotto == true")
        mottoes = localRealm.objects(Motto.self).filter(mottoPredicate)
        
        let lottoPredicate = NSPredicate(format: "isMotto == false")
        lottoes = localRealm.objects(Motto.self).filter(lottoPredicate)

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        mottoBuyCountLabel.text = "\(numberFormatter.string(for: mottoes.count) ?? "0")" + "게임"
        lottoBuyCountLabel.text = "\(numberFormatter.string(for: lottoes.count) ?? "0")" + "게임"
        
        for i in 1...5 {
            let predicate = NSPredicate(format: "prize == %@", NSNumber(integerLiteral: i))
            switch i {
            case 1:
                mottoPrz1CountLabel.text = "\(mottoes.filter(predicate).count)개"
                lottoPrz1CountLabel.text =
                "\(lottoes.filter(predicate).count)개"
            case 2:
                mottoPrz2CountLabel.text = "\(mottoes.filter(predicate).count)개"
                lottoPrz2CountLabel.text =
                "\(lottoes.filter(predicate).count)개"
            case 3:
                mottoPrz3CountLabel.text = "\(mottoes.filter(predicate).count)개"
                lottoPrz3CountLabel.text =
                "\(lottoes.filter(predicate).count)개"
            case 4:
                mottoPrz4CountLabel.text = "\(mottoes.filter(predicate).count)개"
                lottoPrz4CountLabel.text =
                "\(lottoes.filter(predicate).count)개"
            case 5:
                mottoPrz5CountLabel.text = "\(mottoes.filter(predicate).count)개"
                lottoPrz5CountLabel.text =
                "\(lottoes.filter(predicate).count)개"
            default :
                print("error")
            }
        }
    }
    
    @IBAction func onMottoResultButtonClicked(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: ResultViewController.identifier) as? ResultViewController else { return }
        
        vc.isMotto = true
        self.navigationController?.navigationBar.tintColor = .myOrange
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
   

    @IBAction func onLottoResultButtonClicked(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: ResultViewController.identifier) as? ResultViewController else { return }
        vc.isMotto = false
        self.navigationController?.navigationBar.tintColor = .myOrange
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



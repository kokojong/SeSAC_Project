//
//  ResultViewController.swift
//  SeSAC_Motto
//
//  Created by kokojong on 2021/11/20.
//

import UIKit
import RealmSwift

class ResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    static let identifier = "ResultViewController"
    
    let localRealm = try! Realm()
    var mottoes: Results<Motto>!
    var drawResults: Results<DrawResult>!
    var winMottoes: [Motto] = []
    var winDrawResults: [DrawResult] = []
    
    var isMotto: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        if isMotto {
            let predicate = NSPredicate(format: "isMotto == true")
            mottoes = localRealm.objects(Motto.self).filter(predicate)
        } else {
            let predicate = NSPredicate(format: "isMotto == false")
            mottoes = localRealm.objects(Motto.self).filter(predicate)
        }
        
        for motto in mottoes {
            for drawResult in drawResults {
                // 모두 일치한다면
                if motto.mottoDrwtNo1 == drawResult.drwtNo1 && motto.mottoDrwtNo2 == drawResult.drwtNo2 && motto.mottoDrwtNo3 == drawResult.drwtNo3 && motto.mottoDrwtNo4 == drawResult.drwtNo4 && motto.mottoDrwtNo5 == drawResult.drwtNo5 && motto.mottoDrwtNo6 == drawResult.drwtNo6 {

                    if !winMottoes.contains(motto) {
                        winMottoes.append(motto)
                        winDrawResults.append(drawResult)
                    }

                }
            }

        }
        
        if winMottoes.count == 0 {
            emptyLabel.isHidden = false
            if isMotto == true {
                emptyLabel.text = "아깝게 놓친 1등 정보가 없습니다.\n자동 모또를 더 추가해보세요.☺️"
            } else {
                emptyLabel.text = "아깝게 놓친 1등 정보가 없습니다.\n수동 모또를 더 추가해보세요.☺️"
            }
        } else {
            emptyLabel.isHidden = true
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "아깝게 놓친 1등"
        
        
        if isMotto == true {
            let predicate = NSPredicate(format: "isMotto == true")
            mottoes = localRealm.objects(Motto.self).filter(predicate)
        } else {
            let predicate = NSPredicate(format: "isMotto == false")
            mottoes = localRealm.objects(Motto.self).filter(predicate)
        }
        
        drawResults = localRealm.objects(DrawResult.self)
        

        let nibName = UINib(nibName: ResultTableViewCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: ResultTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        for motto in mottoes {
            for drawResult in drawResults {
                // 모두 일치한다면
                if motto.mottoDrwtNo1 == drawResult.drwtNo1 && motto.mottoDrwtNo2 == drawResult.drwtNo2 && motto.mottoDrwtNo3 == drawResult.drwtNo3 && motto.mottoDrwtNo4 == drawResult.drwtNo4 && motto.mottoDrwtNo5 == drawResult.drwtNo5 && motto.mottoDrwtNo6 == drawResult.drwtNo6 {
                    
                    if !winMottoes.contains(motto) {
                        winMottoes.append(motto)
                        winDrawResults.append(drawResult)
                    }
                    
                }
            }
            
        }
        
        if winMottoes.count == 0 {
           
            if isMotto == true {
                emptyLabel.text = "아깝게 놓친 1등 정보가 없습니다.\n자동 모또를 더 추가해보세요.☺️"
            } else {
                emptyLabel.text = "아깝게 놓친 1등 정보가 없습니다.\n수동 모또를 더 추가해보세요.☺️"
            }
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }

        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
        
        
    }
    
    func updateStackViews(stackView: UIStackView, idx: Int) {
        
        let winMotto = winMottoes[idx]
        let winNumberList = [winMotto.mottoDrwtNo1, winMotto.mottoDrwtNo2, winMotto.mottoDrwtNo3, winMotto.mottoDrwtNo4, winMotto.mottoDrwtNo5, winMotto.mottoDrwtNo6]
        var index = 0
        for v in stackView.arrangedSubviews {
            let label = v as! UILabel
            label.clipsToBounds = true
            label.layer.cornerRadius = label.layer.frame.size.width / 2
            label.textColor = .white

            label.text = "\(winNumberList[index])"
     
       
            index += 1
        }
    }
    


      
    
  
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return winMottoes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as? ResultTableViewCell else { return UITableViewCell() }
        
//        cell.testLabel.text = "\(winMottoes[indexPath.row].mottoDrwNo)회차 구매, \(winDrawResults[indexPath.row].drwNo)회차 1등! 상금: \(winDrawResults[indexPath.row].firstWinamnt)"
        
        let winMotto = winMottoes[indexPath.row]
        let winDrawResult = winDrawResults[indexPath.row]
        // 1000회차 구매 번호  1 2 3 4 5 6
//        cell.numberLabel.text = "\(winMotto.mottoDrwNo)회차 구매 번호 \(winMotto.mottoDrwtNo1) \(winMotto.mottoDrwtNo2) \(winMotto.mottoDrwtNo3) \(winMotto.mottoDrwtNo4) \(winMotto.mottoDrwtNo5) \(winMotto.mottoDrwtNo6)"
        
        // 900회차 1등 상금 : 123456789원
//        cell.winLabel.text = "\(winDrawResult.drwNo)회차 1등! 상금 : \(winDrawResult.firstWinamnt)원"
//        cell.backgroundColor = .yellow
        
        switch winMotto.mottoNum {
        case 0: cell.gameLabel.text = "A"
        case 1: cell.gameLabel.text = "B"
        case 2: cell.gameLabel.text = "C"
        case 3: cell.gameLabel.text = "D"
        case 4: cell.gameLabel.text = "E"
        default : cell.gameLabel.text = "Z"
        }
        
        cell.mottoDrawNoLabel.text = "\(winMotto.mottoDrwNo)회차 모또 번호"
        cell.winDrawNoLabel.text = "\(winDrawResult.drwNo)회차 1등 번호"
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        var firstWinamnt: String = ""
        if winDrawResult.firstWinamnt != 0 { // 1등 당첨자가 존재 한다면
            firstWinamnt = numberFormatter.string(for: winDrawResult.firstWinamnt) ?? "0" + "원"
        } else {
            firstWinamnt = "\(numberFormatter.string(for: winDrawResult.firstAccumamnt) ?? "0")" + "/n원"
        }
        cell.winAmountLabel.text = firstWinamnt
        
        cell.bgView.clipsToBounds = true
        cell.bgView.layer.cornerRadius = 8
        updateStackViews(stackView: cell.numbersStackView, idx: indexPath.row)
        
        return cell
    }
    
    
}



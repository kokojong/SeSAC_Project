//
//  BuyViewController.swift
//  SeSAC_Motto
//
//  Created by kokojong on 2021/11/18.
//

import UIKit
import RealmSwift

class BuyViewController: UIViewController {
    
    @IBOutlet weak var mottoCollectionView: UICollectionView!
    @IBOutlet weak var lottoCollectionView: UICollectionView!
    @IBOutlet weak var nextDrawNoLabel: UILabel!
    
    @IBOutlet weak var mottoBuyButton: UIButton!
    @IBOutlet weak var lottoBuyButton: UIButton!
    @IBOutlet weak var mottoBuyCountLabel: UILabel!
    @IBOutlet weak var lottoBuyCountLabel: UILabel!
    
    @IBOutlet weak var mottoEmptyLabel: UILabel!
    @IBOutlet weak var lottoEmptyLabel: UILabel!
    
    
    let localRealm = try! Realm()
    
    var mottoPapers: Results<MottoPaper>! // 해당 회차의 paper(realm 데이터)
    var lottoPapers: Results<MottoPaper>!
    
    var mottoes: Results<Motto>!
    var lottoes: Results<Motto>!
    
    var nextDrawNo = 0 {
        didSet {
            nextDrawNoLabel.text = "\(nextDrawNo)회차"
            print("nextDrawNo",nextDrawNo)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mottoCollectionView.reloadData()
        lottoCollectionView.reloadData()
        nextDrawNo = UserDefaults.standard.integer(forKey: "recentDrawNo") + 1
        updateEmptyLabel()
        updateBuyCountLabel()
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "추가하기"
        
        nextDrawNo = UserDefaults.standard.integer(forKey: "recentDrawNo") + 1
        
        let predicate1 = NSPredicate(format: "mottoPaperDrwNo == %@ AND isMottoPaper == true", NSNumber(integerLiteral: nextDrawNo))
        mottoPapers = localRealm.objects(MottoPaper.self).filter(predicate1)
      
        let predicate2 = NSPredicate(format: "mottoPaperDrwNo == %@ AND isMottoPaper == false",NSNumber(integerLiteral: nextDrawNo))
        lottoPapers = localRealm.objects(MottoPaper.self).filter(predicate2)
        
        mottoCollectionView.delegate = self
        mottoCollectionView.dataSource = self
       
        lottoCollectionView.delegate = self
        lottoCollectionView.dataSource = self
        
        let mottoNibName = UINib(nibName: MottoPaperCollectionViewCell.identifier, bundle: nil)
        mottoCollectionView.register(mottoNibName, forCellWithReuseIdentifier: MottoPaperCollectionViewCell.identifier)
//        let lottoNibName = UINib(nibName: LottoPaperCollectionViewCell.identifier, bundle: nil)
        lottoCollectionView.register(mottoNibName, forCellWithReuseIdentifier: MottoPaperCollectionViewCell.identifier)
        
        let flowLayout1 = UICollectionViewFlowLayout()
        let space: CGFloat = 8
        let inset: CGFloat = 5
        let w = mottoCollectionView.frame.size.width - 5*space
//        let totalWidth = UIScreen.main.bounds.width - 3*space // 2개 배치 -> 공간은 3개 비우기(여백까지)
        flowLayout1.itemSize = CGSize(width: w/2.4, height: w/2)
        
        flowLayout1.scrollDirection = .horizontal // 가로 스크롤
        
        flowLayout1.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset) // padding
        
        let flowLayout2 = UICollectionViewFlowLayout()
//        let totalWidth = UIScreen.main.bounds.width - 3*space // 2개 배치 -> 공간은 3개 비우기(여백까지)
        flowLayout2.itemSize = CGSize(width: w/2.4, height: w/2)
        
        flowLayout2.scrollDirection = .horizontal // 가로 스크롤
        
        flowLayout2.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset) // padding
        
        
        
        mottoCollectionView.collectionViewLayout = flowLayout1
        lottoCollectionView.collectionViewLayout = flowLayout2
        
        mottoBuyButton.clipsToBounds = true
        mottoBuyButton.layer.cornerRadius = 8
        
        lottoBuyButton.clipsToBounds = true
        lottoBuyButton.layer.cornerRadius = 8
        
        updateEmptyLabel()
    
        updateBuyCountLabel()
        
       }
    
    func updateBuyCountLabel() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let mottoPredicate = NSPredicate(format: "mottoDrwNo == %@ AND isMotto == true", NSNumber(integerLiteral: nextDrawNo))
        mottoes = localRealm.objects(Motto.self).filter(mottoPredicate)
        mottoBuyCountLabel.text = numberFormatter.string(for: mottoes.count)! + "게임"
        
        let lottoPredicate = NSPredicate(format: "mottoDrwNo == %@ AND isMotto == false", NSNumber(integerLiteral: nextDrawNo))
        lottoes = localRealm.objects(Motto.self).filter(lottoPredicate)
        lottoBuyCountLabel.text = numberFormatter.string(for: lottoes.count)! + "게임"
    }
    
    func updateEmptyLabel() {
        if mottoPapers.count == 0 {
            mottoEmptyLabel.isHidden = false
            mottoEmptyLabel.text = "\(nextDrawNo)회차의 자동/반자동 모또가 없습니다.\n모또를 더 추가해보세요.☺️"
        } else {
            mottoEmptyLabel.isHidden = true
        }
        
        if lottoPapers.count == 0 {
            lottoEmptyLabel.isHidden = false
            lottoEmptyLabel.text = "\(nextDrawNo)회차의 수동 모또가 없습니다.\n구매 정보를 더 추가해보세요.☺️"
        } else {
            lottoEmptyLabel.isHidden = true
        }
    }
    
    @IBAction func onMottoBuyButtonClicked(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: MottoBuyViewController.identifier) as? MottoBuyViewController else { return }
        
        self.navigationController?.navigationBar.tintColor = .myOrange
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func onLottoBuyButtonClicked(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: LottoBuyViewController.identifier) as? LottoBuyViewController else { return }
        
        self.navigationController?.navigationBar.tintColor = .myOrange
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension BuyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mottoCollectionView {
            return mottoPapers.count
        } else {
            return lottoPapers.count
        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == mottoCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MottoPaperCollectionViewCell.identifier, for: indexPath) as? MottoPaperCollectionViewCell else { return UICollectionViewCell()}
            
            let row = indexPath.row
            
            let predicate = NSPredicate(format: "mottoPaperNum == %@ AND isMottoPaper == true", NSNumber(integerLiteral: row))
            let mottoPaper = mottoPapers.filter(predicate).first!.mottoPaper

            
            for i in 0...mottoPaper.count-1 {
                let predicate = NSPredicate(format: "mottoNum == %@", NSNumber(integerLiteral: i))
                let game = mottoPaper.filter(predicate).first! // 0~4번 게임
                
                let text = "\(String(format: "%02d", game.mottoDrwtNo1)) \(String(format: "%02d", game.mottoDrwtNo2)) \(String(format: "%02d", game.mottoDrwtNo3)) \(String(format: "%02d", game.mottoDrwtNo4)) \(String(format: "%02d", game.mottoDrwtNo5)) \(String(format: "%02d", game.mottoDrwtNo6))"
                switch i {
                case 0 :
                    cell.gameALabel.text = "\(text)"
                    cell.ALabel.text = "A"
                case 1 :
                    cell.gameBLabel.text = "\(text)"
                    cell.BLabel.text = "B"
                case 2 :
                    cell.gameCLabel.text = "\(text)"
                    cell.CLabel.text = "C"
                case 3 :
                    cell.gameDLabel.text = "\(text)"
                    cell.DLabel.text = "D"
                case 4 :
                    cell.gameELabel.text = "\(text)"
                    cell.ELabel.text = "E"
                default : print("default")
                }
                
            
            }
            let buyDate = mottoPapers.filter(predicate).first!.mottoPaperBuyDate
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_kr")
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let str = dateFormatter.string(from: buyDate)
            cell.dateLabel.text = str
            
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 8
            return cell
            
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MottoPaperCollectionViewCell.identifier, for: indexPath) as? MottoPaperCollectionViewCell else { return UICollectionViewCell()}
            
            let row = indexPath.row
            
            let predicate = NSPredicate(format: "mottoPaperNum == %@ AND isMottoPaper == false", NSNumber(integerLiteral: row))
            let lottoPaper = lottoPapers.filter(predicate).first!.mottoPaper
            
            
            cell.ALabel.isHidden = true
            cell.BLabel.isHidden = true
            cell.CLabel.isHidden = true
            cell.DLabel.isHidden = true
            cell.ELabel.isHidden = true
            
            
            for i in 0...lottoPaper.count-1 {
                let predicate = NSPredicate(format: "mottoNum == %@", NSNumber(integerLiteral: i))
                let game = lottoPaper.filter(predicate).first! // 0~4번 게임
                
                let text = "\(String(format: "%02d", game.mottoDrwtNo1)) \(String(format: "%02d", game.mottoDrwtNo2)) \(String(format: "%02d", game.mottoDrwtNo3)) \(String(format: "%02d", game.mottoDrwtNo4)) \(String(format: "%02d", game.mottoDrwtNo5)) \(String(format: "%02d", game.mottoDrwtNo6))"
                
                switch i {
                case 0 :
                    cell.gameALabel.text = "\(text)"
                    cell.ALabel.text = "A"
                    cell.ALabel.isHidden = false
                case 1 :
                    cell.gameBLabel.text = "\(text)"
                    cell.BLabel.text = "B"
                    cell.BLabel.isHidden = false
                case 2 :
                    cell.gameCLabel.text = "\(text)"
                    cell.CLabel.text = "C"
                    cell.CLabel.isHidden = false
                case 3 :
                    cell.gameDLabel.text = "\(text)"
                    cell.DLabel.text = "D"
                    cell.DLabel.isHidden = false
                case 4 :
                    cell.gameELabel.text = "\(text)"
                    cell.ELabel.text = "E"
                    cell.ELabel.isHidden = false
                default : print("default")
                }
                
            
            }
            let buyDate = lottoPapers.filter(predicate).first!.mottoPaperBuyDate
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_kr")
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let str = dateFormatter.string(from: buyDate)
            cell.dateLabel.text = str
            
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 8

            return cell
        }
     
    }
 
    
    
}

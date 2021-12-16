//
//  LottoBuyViewController.swift
//  SeSAC_Motto
//
//  Created by kokojong on 2021/11/25.
//

import UIKit
import RealmSwift
import Toast

class LottoBuyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableViewContainerView: UIView!
    @IBOutlet weak var saveGameButton: UIButton!
    static let identifier = "LottoBuyViewController"
    
    var lottoList: [[Int]] = []
    
    var numberList: [Int] = []
    
    var nextDrawNo = UserDefaults.standard.integer(forKey: "recentDrawNo") + 1
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "수동 모또 추가하기"
        
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableViewContainerView.clipsToBounds = true
        tableViewContainerView.layer.cornerRadius = 8
        
        let tableViewNib = UINib(nibName: LottoTableViewCell.identifier, bundle: nil)
        tableView.register(tableViewNib, forCellReuseIdentifier: LottoTableViewCell.identifier)
        
        let collectionViewNib = UINib(nibName: ManualBuyCollectionViewCell.identifier, bundle: nil)
        collectionView.register(collectionViewNib, forCellWithReuseIdentifier: ManualBuyCollectionViewCell.identifier)
        
        let spacing:CGFloat = 10
        let layout = UICollectionViewFlowLayout()
        let itemSize = (UIScreen.main.bounds.width - 9 * spacing - 40) / 8 // 좌우 제약조건만큼 빼주고 나누기

        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.scrollDirection = .vertical
        
        saveGameButton.clipsToBounds = true
        saveGameButton.layer.cornerRadius = 8

        collectionView.isScrollEnabled = false
        collectionView.collectionViewLayout = layout
        collectionView.allowsMultipleSelection = true
        
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func onSaveGameButtonClicked(_ sender: UIButton) {
        if numberList.count != 6 {
            showAlert(title: "번호 오류", message: "6개의 번호를 선택해주세요")
        } else {
            if lottoList.count < 5 {
                lottoList.append(numberList.sorted())
                self.view.makeToast("게임 정보가 저장되었습니다")
                deselectAll()
            } else {
                showAlert(title: "게임수 오류", message: "한번에 5개의 게임까지 저장이 가능합니다.")
            }
        }
        
        
        tableView.reloadData()
        
        
    }
    
    @IBAction func onSavePaperButtonClicked(_ sender: UIBarButtonItem) {
        
        if lottoList.count == 0 {
            showAlert(title: "게임 정보 없음", message: "최소 한 개 이상의 게임을 추가해주세요")
        } else {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: LottoPaperViewController.identifier) as? LottoPaperViewController else { return }
            
            vc.lottoNumerList = lottoList
            let predicate = NSPredicate(format: "mottoPaperDrwNo == %@ AND isMottoPaper == false", NSNumber(integerLiteral: nextDrawNo))
            vc.mottoPaperCount = localRealm.objects(MottoPaper.self).filter(predicate).count
            vc.isMotto = false
            
            present(vc, animated: true, completion: nil)
            lottoList = []
            
            tableView.reloadData()
        }
    
        
    }
    
}

extension LottoBuyViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 45
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ManualBuyCollectionViewCell.identifier, for: indexPath) as? ManualBuyCollectionViewCell else { return UICollectionViewCell() }
        
        
    
        cell.layer.cornerRadius = cell.layer.frame.size.width / 2
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.backgroundColor = UIColor.clear
        cell.numberLabel.textColor = .lightGray
        cell.numberLabel.text = String(format: "%02d", indexPath.row + 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        numberList.append(indexPath.row + 1)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if numberList.contains(indexPath.row + 1){
            if let index = numberList.firstIndex(of: indexPath.row + 1) {
                numberList.remove(at: index)
            }
        }
        
        
    }
    
    func deselectAll() {
        collectionView.indexPathsForSelectedItems?.forEach {
            collectionView.deselectItem(at: $0, animated: true)
            if let index = numberList.firstIndex(of: $0.row + 1) {
                numberList.remove(at: index)
            }
            
        }
    }
    
    func updateStackViews(stackView: UIStackView, game: Int) {
        
        let numList = lottoList[game]
        var index = 0
        for v in stackView.arrangedSubviews {
            let label = v as! UILabel
            label.clipsToBounds = true
            label.layer.cornerRadius = label.layer.frame.size.width / 2
            label.textColor = .white

            label.text = "\(numList[index])"
     
       
            index += 1
        }
    }
    
}

extension LottoBuyViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lottoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LottoTableViewCell.identifier, for: indexPath) as? LottoTableViewCell else { return UITableViewCell()}
        
        switch indexPath.row {
        case 0:
            cell.gameLabel.text = "A"
            if lottoList[indexPath.row].count > 0{
                updateStackViews(stackView: cell.numbersStackView, game: indexPath.row)
            }
        case 1: cell.gameLabel.text = "B"
        case 2: cell.gameLabel.text = "C"
        case 3: cell.gameLabel.text = "D"
        case 4: cell.gameLabel.text = "E"
        default: print("error")
        }
        if lottoList[indexPath.row].count > 0{
            updateStackViews(stackView: cell.numbersStackView, game: indexPath.row)
        }
        
        
//        cell.testLabel.text = "\(lottoList[indexPath.row][0]) \(lottoList[indexPath.row][1]) \(lottoList[indexPath.row][2]) \(lottoList[indexPath.row][3]) \(lottoList[indexPath.row][4]) \(lottoList[indexPath.row][5]) "
        
        return cell
    }
    
    
    
    
}

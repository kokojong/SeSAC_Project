//
//  AutoBuyViewController.swift
//  SeSAC_Motto
//
//  Created by kokojong on 2021/11/22.
//

import UIKit
import RealmSwift

class MottoBuyViewController: UIViewController {

    @IBOutlet weak var includeCollectionView: UICollectionView!
    @IBOutlet weak var exceptCollectionView: UICollectionView!
    
    static let identifier = "MottoBuyViewController"
    
    var includedNumberList: [Int] = []
    var exceptedNumberList: [Int] = []
    
    let localRealm = try! Realm()
    
    var mottoPapers: Results<MottoPaper>!
    
    var nextDrawNo = UserDefaults.standard.integer(forKey: "recentDrawNo") + 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "자동 모또 추가하기"
        
        mottoPapers = localRealm.objects(MottoPaper.self)
        
        includeCollectionView.delegate = self
        includeCollectionView.dataSource = self
        exceptCollectionView.delegate = self
        exceptCollectionView.dataSource = self

        let nibName = UINib(nibName: ManualBuyCollectionViewCell.identifier, bundle: nil)
        includeCollectionView.register(nibName, forCellWithReuseIdentifier: ManualBuyCollectionViewCell.identifier)
        exceptCollectionView.register(nibName, forCellWithReuseIdentifier: ManualBuyCollectionViewCell.identifier)
        

        let spacing:CGFloat = 10
        let inset:CGFloat = 25
        let includeLayout = UICollectionViewFlowLayout()
        let itemSize = (UIScreen.main.bounds.width - 9 * spacing - 40) / 8 // 좌우 제약조건만큼 빼주고 나누기

        includeLayout.itemSize = CGSize(width: itemSize, height: itemSize)
        includeLayout.minimumLineSpacing = spacing
        includeLayout.minimumInteritemSpacing = spacing
        includeLayout.sectionInset = UIEdgeInsets(top: spacing, left: inset, bottom: spacing, right: inset)
        
        includeLayout.scrollDirection = .vertical

        includeCollectionView.isScrollEnabled = false
        includeCollectionView.collectionViewLayout = includeLayout
        
        let exceptLayout = UICollectionViewFlowLayout()
        exceptLayout.itemSize = CGSize(width: itemSize, height: itemSize)
        exceptLayout.minimumLineSpacing = spacing
        exceptLayout.minimumInteritemSpacing = spacing
        exceptLayout.sectionInset = UIEdgeInsets(top: spacing, left: inset, bottom: spacing, right: inset)
        
        exceptLayout.scrollDirection = .vertical

        exceptCollectionView.isScrollEnabled = false
        exceptCollectionView.collectionViewLayout = exceptLayout
        
        includeCollectionView.allowsMultipleSelection = true
        exceptCollectionView.allowsMultipleSelection = true
        
    }
    @IBAction func onSave5GamesButtonClicked(_ sender: UIBarButtonItem) {
        
        if checkIsPosible() {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: MottoPaperViewController.identifier) as? MottoPaperViewController else { return }
            vc.includedNumberList = self.includedNumberList.sorted()
            vc.exceptedNumberList = self.exceptedNumberList.sorted()

            
            // 여기에
            let predicate = NSPredicate(format: "mottoPaperDrwNo == %@ AND isMottoPaper == true", NSNumber(integerLiteral: nextDrawNo))
            vc.mottoPaperCount = localRealm.objects(MottoPaper.self).filter(predicate).count
            present(vc, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "잘못된 선택", message: "가능한 조합이 없습니다", preferredStyle: .alert)
            let ok = UIAlertAction(title: "다시 설정 하기", style: .default)
            alert.addAction(ok)
        
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func checkIsPosible() -> Bool {
        
        let commonNumList = includedNumberList.filter{exceptedNumberList.contains($0) }
        
        if includedNumberList.count > 6  || exceptedNumberList.count > 39 {
            
            return false
            
        } else if commonNumList.count > 0 {
            return false
        } else {
            return true
        }
        
        
    }
    
}

extension MottoBuyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 45
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == includeCollectionView {
            guard let cell = includeCollectionView.dequeueReusableCell(withReuseIdentifier: ManualBuyCollectionViewCell.identifier, for: indexPath) as? ManualBuyCollectionViewCell else { return UICollectionViewCell() }
            
            cell.layer.cornerRadius = cell.layer.frame.size.width / 2
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.backgroundColor = UIColor.clear
            cell.numberLabel.textColor = .lightGray
            cell.numberLabel.text = String(format: "%02d", indexPath.row + 1)
            
            return cell
            
        }
        else {
            guard let cell = exceptCollectionView.dequeueReusableCell(withReuseIdentifier: ManualBuyCollectionViewCell.identifier, for: indexPath) as? ManualBuyCollectionViewCell else { return UICollectionViewCell() }
            
            cell.layer.cornerRadius = cell.layer.frame.size.width / 2
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.backgroundColor = UIColor.clear
            cell.numberLabel.textColor = .lightGray
            cell.numberLabel.text = String(format: "%02d", indexPath.row + 1)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == includeCollectionView {
            includedNumberList.append(indexPath.row + 1)
 
        } else { // exceptCollectionView
            exceptedNumberList.append(indexPath.row + 1)

        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == includeCollectionView {
            if includedNumberList.contains(indexPath.row + 1){
                if let index = includedNumberList.firstIndex(of: indexPath.row + 1) {
                    includedNumberList.remove(at: index)
                }
            }
        } else {
            if exceptedNumberList.contains(indexPath.row + 1){
                if let index = exceptedNumberList.firstIndex(of: indexPath.row + 1) {
                    exceptedNumberList.remove(at: index)
             
                }
            }
        }
    }
    
}

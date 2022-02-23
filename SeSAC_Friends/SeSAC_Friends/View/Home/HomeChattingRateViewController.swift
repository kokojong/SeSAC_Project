//
//  HomeChattingRateViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/22.
//

import UIKit
import SnapKit
import Then
import SwiftUI


class HomeChattingRateViewController: UIViewController {
    
    var viewModel = HomeViewModel.shared
    
    var rateTags = ["좋은 매너", "정확한 시간 약속", "빠른 응답", "친절한 성격", "능숙한 취미 실력", "유익한 시간"]
    var rateTagsSelected = [0, 0, 0 ,0, 0, 0, 0, 0, 0 ,0] // 3개는 안씀
    
    let chattingRateView = ChattingRateView().then {   $0.titleLabel.text = "리뷰 등록"
        $0.subtitleLabel.text = "님과의 취미 활동은 어떠셨나요?"
        $0.rateTextView.text = "자세한 피드백은 다른 새싹 친구들에게 큰 도움이 됩니다."
        $0.rateButton.setTitle("리뷰 등록하기", for: .normal)
        $0.rateTagCollectionView.then {
            
            $0.register(ChattingRateCollectionViewCell.self, forCellWithReuseIdentifier: ChattingRateCollectionViewCell.identifier)
            
            let flowLayout = UICollectionViewFlowLayout()
            let spacing: CGFloat = 8
            let inset: CGFloat = 0
            flowLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
            
            let cellWidth = (UIScreen.main.bounds.width - 16*4 - spacing)/2
            flowLayout.itemSize = CGSize(width: cellWidth, height: 32)
            
            flowLayout.minimumLineSpacing = 8
            flowLayout.minimumInteritemSpacing = 8
            flowLayout.scrollDirection = .vertical
            
            $0.collectionViewLayout = flowLayout
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.checkMyQueueStatus { myQueueStateResult, statuscode, error in
            
            guard let myQueueStateResult = myQueueStateResult else {
                return
            }

            self.chattingRateView.subtitleLabel.text = "\(myQueueStateResult.matchedNick!)님과의 취미 활동은 어떠셨나요?"
            
            UserDefaults.standard.set(myQueueStateResult.matchedUid, forKey: UserDefaultKeys.otherUid.rawValue)
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black?.withAlphaComponent(0.5)
    
        addViews()
        addConstraints()
        
        chattingRateView.rateTextView.delegate = self
        chattingRateView.rateTagCollectionView.delegate = self
        chattingRateView.rateTagCollectionView.dataSource = self
        chattingRateView.rateTagCollectionView.isUserInteractionEnabled = true
        chattingRateView.rateTagCollectionView.allowsMultipleSelection = true
        
        chattingRateView.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        
        chattingRateView.rateButton.addTarget(self, action: #selector(onRateButtonClicked), for: .touchUpInside)
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func addViews(){
        view.addSubview(chattingRateView)
    }
    
    func addConstraints(){
        chattingRateView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
//        DispatchQueue.main.async {
            self.chattingRateView.rateTagCollectionView.snp.updateConstraints { make in
                make.height.equalTo(112)
            }
//        }
       
    }

    func checkValidation() {
        if rateTagsSelected.reduce(0, +) > 0 {
            chattingRateView.rateButton.style = .fill
        } else {
            chattingRateView.rateButton.style = .disable
        }
    }
    
    @objc func cancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onRateButtonClicked() {
        print(#function)
        
        var comment = ""
        if chattingRateView.rateTextView.textColor == .black {
            comment = chattingRateView.rateTextView.text
        } else {
            comment = ""
        }
        
        let form = WriteReviewFrom(otheruid: UserDefaults.standard.string(forKey: UserDefaultKeys.otherUid.rawValue)!, reputation: rateTagsSelected, comment: comment)
        
        viewModel.writeReview(form: form) { statuscode in
            guard let statuscode = statuscode else {
                return
            }
            switch statuscode {
            case RateStatusCodeCase.success.rawValue:
                UserDefaults.standard.set(MyStatusCase.normal.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                changeRootView(vc: TabBarViewController())
            default:
//                self.view.makeToast("리뷰 작성에 실패했습니다. 잠시 후 다시 시도해주세요.")
                self.view.makeToast("\(statuscode)")
            }
            
            
        }
    }

}

extension HomeChattingRateViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray { // TextColor로 처리합니다. text로 처리하게 된다면 placeholder와 같은걸 써버리면 동작이 이상하겠죠?
            textView.text = nil // 텍스트를 날려줌
            textView.textColor = UIColor.black
        }
        
    }
    
    // UITextView의 placeholder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메세지를 입력하세요"
            textView.textColor = UIColor.lightGray
        }
    }
    
}

extension HomeChattingRateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChattingRateCollectionViewCell.identifier, for: indexPath) as? ChattingRateCollectionViewCell else {
            return UICollectionViewCell()
        }
                
        cell.rateButton.setTitle(rateTags[indexPath.row], for: .normal)
        
        return cell
            
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        rateTagsSelected[indexPath.row] = 1
        checkValidation()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function)
        rateTagsSelected[indexPath.row] = 0
        checkValidation()
    }
    
    
}

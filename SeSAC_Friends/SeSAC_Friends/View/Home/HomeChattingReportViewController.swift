//
//  HomeChattingReportViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/20.
//

import UIKit
import SnapKit
import Then

class HomeChattingReportViewController: UIViewController {

    let chattingReportView = ChattingRateView().then {
        $0.titleLabel.text = "새싹 신고"
        $0.subtitleLabel.text = "다시는 해당 새싹과 매칭되지 않습니다"
        $0.rateTextView.text = "신고 사유를 적어주세요\n허위 신고 시 제재를 받을 수 있습니다"
        $0.rateButton.setTitle("신고하기", for: .normal)
        $0.rateTagCollectionView.then {
            
            $0.register(ChattingRateCollectionViewCell.self, forCellWithReuseIdentifier: ChattingRateCollectionViewCell.identifier)
            
            let flowLayout = UICollectionViewFlowLayout()
            let spacing: CGFloat = 8
            let inset: CGFloat = 0
            flowLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
            
            let cellWidth = ($0.frame.size.width - spacing)/2
            flowLayout.itemSize = CGSize(width: cellWidth, height: 32)
            
            flowLayout.minimumLineSpacing = 8
            flowLayout.minimumInteritemSpacing = 8
            flowLayout.scrollDirection = .vertical
            
            $0.collectionViewLayout = flowLayout
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black?.withAlphaComponent(0.5)
        
        addViews()
        addConstraints()
        
        chattingReportView.rateTextView.delegate = self
      
    }
    
    func addViews(){
        view.addSubview(chattingReportView)
        
        
    }
    
    func addConstraints(){
        chattingReportView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
    }
    


}


extension HomeChattingReportViewController: UITextViewDelegate {
    
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

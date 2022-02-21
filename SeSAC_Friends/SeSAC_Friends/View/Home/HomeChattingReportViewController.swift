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
    
    var viewModel = HomeViewModel.shared

    var reportTags = ["불법/사기", "불편한언행", "노쇼", "선정성", "인신공격", "기타"]
    var reportTagsSelected = [0, 0, 0 ,0, 0, 0]
    
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
            
            let cellWidth = (UIScreen.main.bounds.width - 16*4 - 2*spacing)/3
            flowLayout.itemSize = CGSize(width: cellWidth, height: 32)
            
            flowLayout.minimumLineSpacing = 8
            flowLayout.minimumInteritemSpacing = 8
            flowLayout.scrollDirection = .vertical
            
            $0.collectionViewLayout = flowLayout
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black?.withAlphaComponent(0.5)
        
        addViews()
        addConstraints()
        
        chattingReportView.rateTextView.delegate = self
        chattingReportView.rateTagCollectionView.delegate = self
        chattingReportView.rateTagCollectionView.dataSource = self
        chattingReportView.rateTagCollectionView.isUserInteractionEnabled = true
        chattingReportView.rateTagCollectionView.allowsMultipleSelection = true
        
        chattingReportView.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        
        chattingReportView.rateButton.addTarget(self, action: #selector(onRateButtonClicked), for: .touchUpInside)
        
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
    
    func checkValidation() {
        if reportTagsSelected.reduce(0, +) > 0 {
            chattingReportView.rateButton.style = .fill
        } else {
            chattingReportView.rateButton.style = .disable
        }
    }
    
    
    @objc func cancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func onRateButtonClicked() {
        print(#function)
        if chattingReportView.rateButton.style == .fill {
            
            var comment = ""
            if chattingReportView.rateTextView.textColor == .black {
                comment = chattingReportView.rateTextView.text
            } else {
                comment = ""
            }
            
            let form = ReportOtherFrom(otheruid: UserDefaults.standard.string(forKey: UserDefaultKeys.otherUid.rawValue)!, reportedReputation: reportTagsSelected, comment: comment)
            viewModel.reportOtherUser(form: form) { statuscode in
                
                
                switch statuscode {
                case ReportOtherStatusCodeCase.success.rawValue:
                    self.view.makeToast("신고 완료")
                case ReportOtherStatusCodeCase.reported.rawValue:
                    self.view.makeToast("이미 신고한 유저입니다")
                default:
                    self.view.makeToast("오류가 발생했습니다. 잠시 후 다시 시도해주세요")
                }
            }
            
        } else {
            self.view.endEditing(true)
            view.makeToast("최소 한 개의 신고 항목을 선택해주세요")
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

extension HomeChattingReportViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChattingRateCollectionViewCell.identifier, for: indexPath) as? ChattingRateCollectionViewCell else {
            return UICollectionViewCell()
        }
                
        cell.rateButton.setTitle(reportTags[indexPath.row], for: .normal)
        
        return cell
            
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        reportTagsSelected[indexPath.row] = 1
        checkValidation()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function)
        reportTagsSelected[indexPath.row] = 0
        checkValidation()
    }
    
    
}

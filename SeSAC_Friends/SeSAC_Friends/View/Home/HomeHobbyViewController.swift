//
//  HomeHobbyViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/08.
//

import UIKit
import SnapKit
import Then

class HomeHobbyViewController: UIViewController, UiViewProtocol {
    
    let backButton = BackButton()
    let searchView = SearchView().then {
        $0.textField.placeholder = "띄어쓰기로 복수 입력이 가능해요"
    }
    
    let nearHobbyLabel = UILabel().then {
        $0.font = .Title6_R12
        $0.textColor = .black
        $0.text = "지금 주변에는"
    }
    
//    let nearHobbyCollectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
//
//        $0.register(HomeNearHobbyCollectionVIewCell.self, forCellWithReuseIdentifier: HomeNearHobbyCollectionVIewCell.identifier)
//
//        let flowLayout = UICollectionViewFlowLayout()
//        let spacing: CGFloat = 8
//        let inset: CGFloat = 0
//        flowLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
//        let width =
////        flowLayout.itemSize = CGSize(width:totalWidth/2, height: 32)
//        flowLayout.minimumLineSpacing = 8
//        flowLayout.minimumInteritemSpacing = 8
//        flowLayout.scrollDirection = .vertical
//
//        $0.collectionViewLayout = flowLayout
//
//
//    }
    
    let nearHobbyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        
        $0.isScrollEnabled = false
        $0.collectionViewLayout = layout
        $0.register(HomeNearHobbyCollectionVIewCell.self, forCellWithReuseIdentifier: HomeNearHobbyCollectionVIewCell.identifier)
        
    }
    
    let favoriteHobbyLabel = UILabel().then {
        $0.font = .Title6_R12
        $0.textColor = .black
        $0.text = "내가 하고 싶은"
    }
    
//    let favoriteHobbyCollectionView = DynamicHeightCollectionView()
    
    let hobbyList: [String] = ["아", "아아아", "아아아아", "asdfasdf","asfsdf","asdf"]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "hobby"
        view.backgroundColor = .yellow
        
        addViews()
        addConstraints()
        
//        setupCollectionView()
        
        nearHobbyCollectionView.delegate = self
        nearHobbyCollectionView.dataSource = self
        nearHobbyCollectionView.register(HomeNearHobbyCollectionVIewCell.self, forCellWithReuseIdentifier: HomeNearHobbyCollectionVIewCell.identifier)
        
//        favoriteHobbyCollectionView.delegate = self
//        favoriteHobbyCollectionView.dataSource = self
        
        backButton.addTarget(self, action: #selector(onBackArrowButtonClicked), for: .touchUpInside)
        
    }
    
    func addViews() {
        view.addSubview(backButton)
        view.addSubview(searchView)
        view.addSubview(nearHobbyLabel)
        view.addSubview(nearHobbyCollectionView)
    }
    
    func addConstraints() {
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchView)
            make.leading.equalToSuperview().inset(16)
        }
        
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(backButton.snp.trailing).offset(8)
//            make.height.equalTo(36)
        }
        
        nearHobbyLabel.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        nearHobbyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(nearHobbyLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
//            make.height.equalTo(400)
            
        }
    }
    
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 100
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        nearHobbyCollectionView.collectionViewLayout = flowLayout
        nearHobbyCollectionView.delegate = self
        nearHobbyCollectionView.dataSource = self
        nearHobbyCollectionView.backgroundColor = .white
        nearHobbyCollectionView.register(HomeNearHobbyCollectionVIewCell.self, forCellWithReuseIdentifier: HomeNearHobbyCollectionVIewCell.identifier)
       }
    
    @objc func onBackArrowButtonClicked() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension HomeHobbyViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case nearHobbyCollectionView:
            return 2
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 6
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == nearHobbyCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeNearHobbyCollectionVIewCell.identifier, for: indexPath) as? HomeNearHobbyCollectionVIewCell else {
                return UICollectionViewCell()
            }
            
            switch indexPath.section {
            case 0:
                cell.borderView.layer.borderColor = UIColor.errorColor?.cgColor
                cell.hobbyLabel.textColor = .errorColor
            default:
                cell.borderView.layer.borderColor = UIColor.gray4?.cgColor
            }
            
            cell.hobbyLabel.text = hobbyList[indexPath.row]
            
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeNearHobbyCollectionVIewCell.identifier, for: indexPath) as? HomeNearHobbyCollectionVIewCell else {
                return UICollectionViewCell()
            }
            
            cell.hobbyLabel.text = "aaa"
//            cell.configureLabelText(text: hobbyList[indexPath.row])
            cell.backgroundColor = .white
            
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let dummyCell = UILabel().then {
            $0.font = .Title4_R14
            $0.text = hobbyList[indexPath.row]
            $0.sizeToFit()
        }
        let size = dummyCell.frame.size
        print("size",size)

        return CGSize(width: size.width+34, height: 32)
        
//        return CGSize(width: 100, height: 50)


    }
    
    
    
    
    
}

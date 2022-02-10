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
    
    let nearHobbyCollectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: .init()).then {
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
    
    let favoriteHobbyCollectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        
        $0.isScrollEnabled = false
        $0.collectionViewLayout = layout
        $0.register(HomeFavoriteHobbyCollectionViewCell.self, forCellWithReuseIdentifier: HomeFavoriteHobbyCollectionViewCell.identifier)
    }
    
    let searchButton = MainButton(type: .fill).then {
        $0.setTitle("새싹 찾기", for: .normal)
    }
    

    var viewModel = HomeViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "hobby"
        view.backgroundColor = .yellow
        
        addViews()
        addConstraints()
        
        nearHobbyCollectionView.delegate = self
        nearHobbyCollectionView.dataSource = self
        
        favoriteHobbyCollectionView.delegate = self
        favoriteHobbyCollectionView.dataSource = self
        
        backButton.addTarget(self, action: #selector(onBackArrowButtonClicked), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(onSearchButtonClicked), for: .touchUpInside)
    }
    
    func addViews() {
        view.addSubview(backButton)
        view.addSubview(searchView)
        view.addSubview(nearHobbyLabel)
        view.addSubview(nearHobbyCollectionView)
        view.addSubview(favoriteHobbyLabel)
        view.addSubview(favoriteHobbyCollectionView)
        view.addSubview(searchButton)
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
        }
        
        nearHobbyLabel.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        nearHobbyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(nearHobbyLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        favoriteHobbyLabel.snp.makeConstraints { make in
            make.top.equalTo(nearHobbyCollectionView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        favoriteHobbyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(favoriteHobbyLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            
        }
        
        searchButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
            
        }
        
        
    }
    
    @objc func onBackArrowButtonClicked() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func onSearchButtonClicked() {
        print(#function)
    }
    
}

extension HomeHobbyViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case nearHobbyCollectionView:
            return 2
        case favoriteHobbyCollectionView:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == nearHobbyCollectionView{
            switch section {
            case 0:
                return viewModel.fromRecommendHobby.value.count
            case 1:
                return viewModel.fromNearFriendsHobby.value.count
            default:
                return 0
            }
            
        } else {
            return viewModel.myFavoriteHobby.value.count
            
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
                cell.hobbyLabel.text = viewModel.fromRecommendHobby.value[indexPath.row]
            case 1:
                cell.borderView.layer.borderColor = UIColor.gray4?.cgColor
                cell.hobbyLabel.text = viewModel.fromNearFriendsHobby.value[indexPath.row]
            default:
                cell.hobbyLabel.text = ""
            }
            
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFavoriteHobbyCollectionViewCell.identifier, for: indexPath) as? HomeFavoriteHobbyCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            
            cell.hobbyLabel.text = viewModel.myFavoriteHobby.value[indexPath.row]
            cell.backgroundColor = .white
            
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == nearHobbyCollectionView {
            switch indexPath.section {
            case 0:
                let dummyCell = UILabel().then {
                    $0.font = .Title4_R14
                    $0.text = viewModel.fromRecommendHobby.value[indexPath.row]
                    $0.sizeToFit()
                }
                let size = dummyCell.frame.size
                return CGSize(width: size.width+34, height: 32)
          
            default:
                let dummyCell = UILabel().then {
                    $0.font = .Title4_R14
                    $0.text = viewModel.fromNearFriendsHobby.value[indexPath.row]
                    $0.sizeToFit()
                }
                let size = dummyCell.frame.size
                return CGSize(width: size.width+34, height: 32)
            }
            
            
        } else {
            let dummyCell = UILabel().then {
                $0.font = .Title4_R14
                $0.text = viewModel.myFavoriteHobby.value[indexPath.row]
                $0.sizeToFit()
            }
            let size = dummyCell.frame.size
            print("size",size)

            return CGSize(width: size.width+54, height: 32)
            
            
        }
    }
    
    
    
    
    
}

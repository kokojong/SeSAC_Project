//
//  HomeHobbyViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/08.
//

import UIKit
import SnapKit
import Then
import Toast

class HomeHobbyViewController: UIViewController, UiViewProtocol {
    
    let backButton = BackButton()
    let searchView = SearchView().then {
        $0.textField.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        $0.textField.returnKeyType = UIReturnKeyType.done
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
    
    // MARK: 내가 하고 싶은 취미 고른거(임시배열), 검색 버튼 누르면 VM에 저장하기
    var myFavoriteHobby: [String] = []
    var newFavoriteHobby: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "hobby"
        view.backgroundColor = .yellow
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
   
        addViews()
        addConstraints()
        
        nearHobbyCollectionView.delegate = self
        nearHobbyCollectionView.dataSource = self
        
        favoriteHobbyCollectionView.delegate = self
        favoriteHobbyCollectionView.dataSource = self
        
        searchView.textField.delegate = self
    
        
        backButton.addTarget(self, action: #selector(onBackArrowButtonClicked), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(onSearchButtonClicked), for: .touchUpInside)
        searchView.textField.addTarget(self, action: #selector(onSearchTextFieldEditingChanged), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: self.view.window)
        

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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func checkHobbyValidation(newHobbys: [String]) -> Bool {
        var style = ToastStyle()
        style.titleColor = UIColor.white!
        
        if myFavoriteHobby.count + newHobbys.count >= 8 {
            view.makeToast("취미를 더 이상 추가할 수 없습니다.\n취미는 최대 8개까지 추가가 가능합니다.", duration: 1.0, position: .center, style: style)
            return false
        }
        
        for hobby in newHobbys {
            if hobby.count > 8 {
                view.makeToast("취미는 최소 한 자 이상, 최대 8글자까지 작성 가능합니다", duration: 1.0, position: .center,  style: style)
            }
        }
        
        return true
    }
    
    @objc func onBackArrowButtonClicked() {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @objc func onSearchButtonClicked() {
        print(#function)
                
        if checkHobbyValidation(newHobbys: []) {
            searchView.textField.endEditing(true)
            viewModel.myFavoriteHobby.value = myFavoriteHobby
        }
        
        let form = PostQueueForm(type: 2, region: viewModel.centerRegion.value, lat: viewModel.centerLat.value, long: viewModel.centerLong.value, hf: viewModel.myFavoriteHobby.value)
        
        viewModel.postQueue(form: form) { statuscode, error in
            guard let statuscode = statuscode else {
                return
            }

            self.view.makeToast("\(statuscode)")
            switch statuscode {
            case QueueStatusCodeCase.success.rawValue:
                UserDefaults.standard.set(MyStatusCase.matching.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                
                let form = OnQueueForm(region: self.viewModel.centerRegion.value, lat: self.viewModel.centerLat.value, long: self.viewModel.centerLong.value)
                self.viewModel.searchNearFriends(form: form) { onqueueResult, statuscode, error in
                    
                    guard let onqueueResult = onqueueResult else {
                        return
                    }
                    
                    switch self.viewModel.searchGender.value {
                        
                    case GenderCase.man.rawValue, GenderCase.woman.rawValue:
                        self.viewModel.filteredQueueDB.value = onqueueResult.fromQueueDB.filter({
                            $0.gender == self.viewModel.searchGender.value
                        })

                    default:
                        self.viewModel.filteredQueueDB.value = onqueueResult.fromQueueDB
                    }
                    
                    self.viewModel.filteredQueueDBRequested.value = onqueueResult.fromQueueDBRequested
                    
                }
                
                self.navigationController?.pushViewController(HomeFindSesacViewController(), animated: true)
//                let modalVC = HomeFindSesacViewController()
//                modalVC.modalPresentationStyle = .fullScreen
//                self.present(modalVC, animated: true, completion: nil)
            case QueueStatusCodeCase.blockedUser.rawValue:
                self.view.makeToast("신고가 누적되어 이용하실 수 없습니다")
            case QueueStatusCodeCase.cancelPanlty1.rawValue:
                self.view.makeToast("약속 취소 패널티로, 1분동안 이용하실 수 없습니다")
            case QueueStatusCodeCase.cancelPanlty2.rawValue:
                self.view.makeToast("약속 취소 패널티로, 2분동안 이용하실 수 없습니다")
            case QueueStatusCodeCase.cancelPanlty3.rawValue:
                self.view.makeToast("연속으로 약속을 취소하셔서 3분동안 이용하실 수 없습니다")
            case QueueStatusCodeCase.invalidGender.rawValue:
                self.view.makeToast("새싹 찾기 기능을 이용하기 위해서는 성별이 필요해요")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.present(ProfileDetailViewController(), animated: true) {
                        self.viewModel.getUserInfo { userInfo, statuscode, error in
                            if let userInfo = userInfo {
                                self.nearHobbyCollectionView.reloadData()
                                self.favoriteHobbyCollectionView.reloadData()
                            }
                        }
                    }
                }
            case QueueStatusCodeCase.firebaseTokenError.rawValue:
                self.refreshFirebaseIdToken { idToken, error in
                    if let idToken = idToken {
                        self.onSearchButtonClicked()
                    }
                }
                
            default:
                self.view.makeToast("취미를 함께할 친구 찾기에 실패했습니다. 잠시 후 다시 시도해주세요.")
            }
            
            
        }
    }
    
    @objc func onSearchTextFieldEditingChanged() {
        
        newFavoriteHobby = searchView.textField.text?.components(separatedBy: " ").filter({
            $0.count > 0
        }) ?? []
        
        print("myFavoriteHobby", myFavoriteHobby)
        print("newFavoriteHobby",newFavoriteHobby)
        checkHobbyValidation(newHobbys: newFavoriteHobby)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            searchButton.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(keyboardSize.height)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(48)
            }
        }
                
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        searchButton.snp.remakeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
    
    
}

extension HomeHobbyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        var style = ToastStyle()
        style.titleColor = UIColor.white!
        
        if textField.text?.count == 0 || newFavoriteHobby.filter({$0.count > 8}).count > 0 {
            view.makeToast("취미는 최소 한 자 이상, 최대 8글자까지 작성 가능합니다", duration: 1.0, position: .center,  style: style)
        
        } else if checkHobbyValidation(newHobbys: newFavoriteHobby) {
            
            textField.resignFirstResponder()
            
            myFavoriteHobby.append(contentsOf: newFavoriteHobby.filter({
                !myFavoriteHobby.contains($0)
            }))
            searchView.textField.text = ""
            newFavoriteHobby = []
        }
        
        favoriteHobbyCollectionView.reloadData()
        
        
        return true
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
//            return viewModel.myFavoriteHobby.value.count
            return myFavoriteHobby.count
            
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
            
            
//            cell.hobbyLabel.text = viewModel.myFavoriteHobby.value[indexPath.row]
            cell.hobbyLabel.text = myFavoriteHobby[indexPath.row]
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
                return CGSize(width: size.width+34, height: size.height+14)
          
            default:
                let dummyCell = UILabel().then {
                    $0.font = .Title4_R14
                    $0.text = viewModel.fromNearFriendsHobby.value[indexPath.row]
                    $0.sizeToFit()
                }
                let size = dummyCell.frame.size
                return CGSize(width: size.width+34, height: size.height+14)
            }
            
            
        } else {
            let dummyCell = UILabel().then {
                $0.font = .Title4_R14
                $0.text = myFavoriteHobby[indexPath.row]
                $0.sizeToFit()
            }
            let size = dummyCell.frame.size

            return CGSize(width: size.width+54, height: size.height+14)
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        if collectionView == nearHobbyCollectionView {
            if checkHobbyValidation(newHobbys: []) {
                switch indexPath.section {
                case 0:
                    if !myFavoriteHobby.contains(viewModel.fromRecommendHobby.value[indexPath.row]){
                        myFavoriteHobby.append(viewModel.fromRecommendHobby.value[indexPath.row])
                    }
                   
                default:
                    if !myFavoriteHobby.contains(viewModel.fromNearFriendsHobby.value[indexPath.row]){
                        myFavoriteHobby.append(viewModel.fromNearFriendsHobby.value[indexPath.row])
                    }
                    
                }
                
            }
            
            
        } else {
            // MARK: 특정한 요소 삭제
            if let index = myFavoriteHobby.firstIndex(of: myFavoriteHobby[indexPath.row]) {
                myFavoriteHobby.remove(at: index)
            }
            
        }
        
        favoriteHobbyCollectionView.reloadData()
        
    }
    
    
    
    
    
}

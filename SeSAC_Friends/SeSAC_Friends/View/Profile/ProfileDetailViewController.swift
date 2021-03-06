//
//  ViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/26.
//

import UIKit
import SnapKit
import RangeSeekSlider

class ProfileDetailViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let backgroundView = ProfileBackgroundView().then {
        $0.matchButton.isHidden = true
    }
    let toggleTableView = UITableView()
    let settingView = UIView()
    let bottomView = ProfileDetailBottomView()

    var isOpen = false
    
    var viewModel = ProfileViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.viewModel.getUserInfo { userInfo, status, error in
                guard let userInfo = userInfo else {
                    return
                }

                self.viewModel.myUserInfo.value = userInfo
                self.viewModel.updateObservables()
                self.toggleTableView.reloadData()
                
                self.viewModel.myUserInfo.bind { userInfo in
                    print("userInfo bind",userInfo)
                    switch userInfo.gender {
                    case GenderCase.man.rawValue:
                        self.bottomView.manButton.style = .fill
                        self.bottomView.womanButton.style = .inactiveButton
                    case GenderCase.woman.rawValue:
                        self.bottomView.manButton.style = .inactiveButton
                        self.bottomView.womanButton.style = .fill
                    default:
                        self.bottomView.manButton.style = .inactiveButton
                        self.bottomView.womanButton.style = .inactiveButton
                    }
                    self.bottomView.hobbyTextField.text = userInfo.hobby
                    self.bottomView.allowSearchSwitch.isOn = userInfo.searchable == 0 ? false : true
                    self.viewModel.searchable.value = userInfo.searchable
                    self.bottomView.ageRangeLabel.text = "\(userInfo.ageMin) - \(userInfo.ageMax)"
                    
                    self.bottomView.ageSlider.selectedMaxValue = CGFloat(self.viewModel.myUserInfo.value.ageMax)
                    self.bottomView.ageSlider.selectedMinValue = CGFloat(userInfo.ageMin)
                    
                    // MARK: Refresh??? ????????? minvalue??? maxValue??? ?????? ????????? bind?????? ??????
                    self.bottomView.ageSlider.minValue = 18
                    self.bottomView.ageSlider.maxValue = 65
                    
                    self.setSesacFaceView(face: userInfo.sesac)
                    self.setSesacBackgroundView(background: userInfo.background)
                    
                    self.bottomView.reloadInputViews()
                    
                    
                    
                }
                
            }
        }
        
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "?????? ??????"

        view.backgroundColor = .white
        
        addViews()
        addConstraints()
        configViews()
        
        toggleTableView.delegate = self
        toggleTableView.dataSource = self
        toggleTableView.register(ClosedTableViewCell.self, forCellReuseIdentifier: ClosedTableViewCell.identifier)
        toggleTableView.register(OpenedTableViewCell.self, forCellReuseIdentifier: OpenedTableViewCell.identifier)
        toggleTableView.rowHeight = UITableView.automaticDimension
        toggleTableView.estimatedRowHeight = 310
        toggleTableView.isUserInteractionEnabled = true
        toggleTableView.isScrollEnabled = false
        toggleTableView.reloadData()
        
        bottomView.ageSlider.delegate = self
        
        setNavBackArrowButton()
        let updateUserInfoBarButton = UIBarButtonItem(title: "??????", style: .done, target: self, action: #selector(updateUserInfoBarButtonClicked))
        updateUserInfoBarButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = updateUserInfoBarButton

        
        bottomView.manButton.addTarget(self, action: #selector(onManButtonClicked), for: .touchUpInside)
        bottomView.womanButton.addTarget(self, action: #selector(onWomanButtonClicked), for: .touchUpInside)
        bottomView.allowSearchSwitch.addTarget(self, action: #selector(allowSearchSwitchValueChanged), for: .valueChanged)
        bottomView.hobbyTextField.addTarget(self, action: #selector(habitTextFieldTextChanged), for: .editingChanged)
        
        let tapRecognizer = ClickListener(target: self, action: #selector(onWithDrawLabelClicked))
        bottomView.withDrawLabel.isUserInteractionEnabled = true
        bottomView.withDrawLabel.addGestureRecognizer(tapRecognizer)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backgroundView)
        contentView.addSubview(toggleTableView)
        contentView.addSubview(bottomView)
    }
    
    func addConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            
        }
        
        toggleTableView.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(58)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        
        
    }
    
    func configViews() {
        toggleTableView.backgroundColor = .red
        toggleTableView.isScrollEnabled = false
        
        bottomView.backgroundColor = .white
        
        scrollView.backgroundColor = .white
        contentView.backgroundColor = .white
    }
    
    func setSesacFaceView(face: Int) {
        backgroundView.faceImageView.image = UIImage(named: "sesac_face_\(face+1)")
    }
    
    func setSesacBackgroundView(background: Int) {
        backgroundView.backgroundImageView.image = UIImage(named: "sesac_background_\(background+1)")
    }
    
    
    func withDrawSignUp() {
        
        UserAPIService.withdrawSignUp(idToken: UserDefaults.standard.string(forKey: UserDefaultKeys.idToken.rawValue)!) { statuscode, error in
            
            switch statuscode {
            case UserStatusCodeCase.success.rawValue, UserStatusCodeCase.unAuthorized.rawValue:
                if statuscode == UserStatusCodeCase.success.rawValue {
                    self.view.makeToast("??????????????? ??????????????????. ??? ???????????? ???????????????")
                    UserDefaults.standard.set(MyStatusCase.normal.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                } else {
                    self.view.makeToast("?????? ?????? ????????? ???????????????. ??? ???????????? ???????????????")
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    windowScene.windows.first?.rootViewController = OnboardingViewController()
                    windowScene.windows.first?.makeKeyAndVisible()
                    UIView.transition(with: windowScene.windows.first!, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
                }
            case UserStatusCodeCase.firebaseTokenError.rawValue:
                self.refreshFirebaseIdToken { idToken, error in
                    if let idToken = idToken {
                        self.withDrawSignUp()
                    }
                }
                
            case UserStatusCodeCase.serverError.rawValue:
                self.view.makeToast("?????? ????????? ?????? ????????? ??????????????????. ?????? ??? ?????? ??????????????????")
            default:
                self.view.makeToast("?????? ????????? ??????????????????. ?????? ??? ?????? ??????????????????")
            }
            
            
            
        }
    }
    
    @objc func onManButtonClicked() {
        viewModel.gender.value = GenderCase.man.rawValue
        print(viewModel.gender.value)
        self.bottomView.manButton.style = .fill
        self.bottomView.womanButton.style = .inactiveButton
    }
    
    @objc func onWomanButtonClicked() {
        viewModel.gender.value = GenderCase.woman.rawValue
        print(viewModel.gender.value)
        self.bottomView.manButton.style = .inactiveButton
        self.bottomView.womanButton.style = .fill
        
    }
    
    @objc func onToggleButtonClicked() {
        isOpen.toggle()
        toggleTableView.reloadData()
        
    }
    
    @objc func updateUserInfoBarButtonClicked() {
        
        let updateMypageForm = UpdateMypageForm(searchable: viewModel.searchable.value, ageMin: viewModel.ageMin.value, ageMax: viewModel.ageMax.value, gender: viewModel.gender.value, hobby: viewModel.hobby.value)
        viewModel.updateMypage(form: updateMypageForm) { statuscode in

            
            switch statuscode {
            case UserStatusCodeCase.success.rawValue :
                self.view.makeToast("????????? ?????????????????????")
            case UserStatusCodeCase.firebaseTokenError.rawValue :
                self.refreshFirebaseIdToken { idToken, error in
                    
                    self.viewModel.updateMypage(form: updateMypageForm) { statuscode in
                        switch statuscode {
                        case UserStatusCodeCase.success.rawValue:
                            self.view.makeToast("????????? ?????????????????????")
                        default:
                            self.view.makeToast("??? ?????? ????????? ??????????????????. ?????? ?????? ?????? ??????????????????")
                        }
                    }
                    
                }
            default :
                self.view.makeToast("??? ?????? ????????? ??????????????????. ?????? ?????? ?????? ??????????????????")
            }
        }
        
    }
    
    @objc func habitTextFieldTextChanged() {
        viewModel.hobby.value = bottomView.hobbyTextField.text ?? ""
        
    }
    
    @objc func allowSearchSwitchValueChanged(searchSwitch: UISwitch) {
        viewModel.searchable.value = searchSwitch.isOn == true ? 1 : 0
        
    }
    
    @objc func onWithDrawLabelClicked() {
        let alert = UIAlertController(title: "????????????", message: "????????? ?????? ????????? ?????????????????????????", preferredStyle: .alert)
        let ok = UIAlertAction(title: "??????", style: .destructive) { alertaction in
            self.withDrawSignUp()
        }
        let cancel = UIAlertAction(title: "??????", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }

}

extension ProfileDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isOpen {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:OpenedTableViewCell.identifier, for: indexPath) as? OpenedTableViewCell else { return UITableViewCell() }
        
            cell.moreButton.setImage(UIImage(named: "more_arrow_up"), for: .normal)
            cell.moreButton.addTarget(self, action: #selector(onToggleButtonClicked), for: .touchUpInside)
            
            
            viewModel.myUserInfo.bind { userInfo in
                cell.nicknameLabel.text = userInfo.nick
                cell.myReviewLabel.text = userInfo.comment.last ?? "??? ????????? ???????????? ????????????"
                cell.reputationCount = userInfo.reputation
                    
            }
            
            cell.layoutIfNeeded()
            
            DispatchQueue.main.async {
                self.toggleTableView.snp.updateConstraints { make in
                    make.height.equalTo(self.toggleTableView.contentSize.height)
                }
                
            }
            
            return cell
            
            
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:ClosedTableViewCell.identifier, for: indexPath) as? ClosedTableViewCell else { return UITableViewCell() }

            viewModel.myUserInfo.bind { userInfo in
                cell.nicknameLabel.text = userInfo.nick
            }
            
            cell.moreButton.setImage(UIImage(named: "more_arrow_down"), for: .normal)
            cell.moreButton.addTarget(self, action: #selector(onToggleButtonClicked), for: .touchUpInside)

            cell.layoutIfNeeded()
        
            
            DispatchQueue.main.async {
                self.toggleTableView.snp.updateConstraints { make in
                    make.height.equalTo(self.toggleTableView.contentSize.height)
                }
                
            }
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isOpen {
            return UITableView.automaticDimension
//            return 310
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isOpen.toggle()
        
        toggleTableView.reloadData()
    }
    
    
    
}


extension ProfileDetailViewController: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        viewModel.ageMin.value = Int(minValue)
        viewModel.ageMax.value = Int(maxValue)
        self.bottomView.ageRangeLabel.text = "\(Int(minValue)) - \(Int(maxValue))"
    }
    
}

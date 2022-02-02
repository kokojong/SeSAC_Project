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
    let backgroundView = ProfileBackgroundView()
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

                self.viewModel.userInfo.value = userInfo
                self.viewModel.updateObservables()
                self.toggleTableView.reloadData()
                
                self.viewModel.userInfo.bind { userInfo in
                    print("userInfo bind",userInfo)
                    switch userInfo.gender {
                    case gender.man.rawValue:
                        self.bottomView.manButton.style = .fill
                        self.bottomView.womanButton.style = .inactiveButton
                    case gender.woman.rawValue:
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
                    
                    self.bottomView.ageSlider.selectedMaxValue = CGFloat(self.viewModel.userInfo.value.ageMax)
                    self.bottomView.ageSlider.selectedMinValue = CGFloat(userInfo.ageMin)
                    
                    // MARK: Refresh를 위해서 minvalue와 maxValue에 대한 적용을 bind에서 해준다
                    self.bottomView.ageSlider.minValue = 18
                    self.bottomView.ageSlider.maxValue = 65
                    
                    self.bottomView.reloadInputViews()
                }
                
            }
        }
        
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "정보 관리"

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
        
        setLeftArrowButton()
        let updateUserInfoBarButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(updateUserInfoBarButtonClicked))
        updateUserInfoBarButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = updateUserInfoBarButton

        
        bottomView.manButton.addTarget(self, action: #selector(onManButtonClicked), for: .touchUpInside)
        bottomView.womanButton.addTarget(self, action: #selector(onWomanButtonClicked), for: .touchUpInside)
        bottomView.allowSearchSwitch.addTarget(self, action: #selector(allowSearchSwitchValueChanged), for: .valueChanged)
        bottomView.hobbyTextField.addTarget(self, action: #selector(habitTextFieldTextChanged), for: .editingChanged)
        
        
        
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
    
    @objc func onManButtonClicked() {
        viewModel.gender.value = gender.man.rawValue
        print(viewModel.gender.value)
        self.bottomView.manButton.style = .fill
        self.bottomView.womanButton.style = .inactiveButton
    }
    
    @objc func onWomanButtonClicked() {
        viewModel.gender.value = gender.woman.rawValue
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
//            print(statuscode)
            switch statuscode {
            case 200 :
                self.view.makeToast("수정이 완료되었습니다")
            case 401:
                self.view.makeToast("fcm 토큰 오류")
            default :
                self.view.makeToast("내 정보 수정에 실패했습니다. 잠시 후에 다시 시도해주세요")
            }
        }
        print("updateMypageForm",updateMypageForm)
//        viewModel.updateMypage(form: updateMypageForm)
        
    }
    
    @objc func habitTextFieldTextChanged() {
        viewModel.hobby.value = bottomView.hobbyTextField.text ?? ""
    }
    
    @objc func allowSearchSwitchValueChanged(searchSwitch: UISwitch) {
        viewModel.searchable.value = searchSwitch.isOn == true ? 1 : 0
        print("searchSwitch", viewModel.searchable.value)
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
            
            viewModel.userInfo.bind { userInfo in
                cell.nicknameLabel.text = userInfo.nick
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

            viewModel.userInfo.bind { userInfo in
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

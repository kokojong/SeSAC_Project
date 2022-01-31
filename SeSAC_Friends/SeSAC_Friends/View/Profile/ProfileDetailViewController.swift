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
    
    var viewModel: ProfileViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleTableView.reloadData()
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
        
        viewModel.userInfo.bind { userInfo in
            
            switch userInfo.gender {
            case 0 :
                self.bottomView.manButton.style = .fill
            case 1:
                self.bottomView.womanButton.style = .fill
            default:
                self.bottomView.manButton.style = .inactiveButton
                self.bottomView.womanButton.style = .inactiveButton
                
            }
            self.bottomView.habitTextField.text = userInfo.hobby
            self.bottomView.habitTextField.placeholder = "취미를 입력해 주세요"
            self.bottomView.allowSearchSwitch.isOn = userInfo.searchable == 0 ? false : true
            self.bottomView.ageRangeLabel.text = "\(userInfo.ageMin) - \(userInfo.ageMax)"
        }
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
        backgroundView.backgroundColor = .yellow
        toggleTableView.backgroundColor = .red
        toggleTableView.isScrollEnabled = false
        
        bottomView.backgroundColor = .yellow
        
        scrollView.backgroundColor = .blue
        contentView.backgroundColor = .brown

        
    }
    
    @objc func onToggleButtonClicked() {
        isOpen.toggle()
        toggleTableView.reloadData()
        
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
//        if isOpen {
//            toggleTableView.snp.updateConstraints { make in
//                make.height.equalTo(300)
//            }
//
//        } else {
//            toggleTableView.snp.updateConstraints { make in
//                make.height.equalTo(58)
//            }
//
//        }
        
        toggleTableView.reloadData()
    }
    
    
    
}


extension ProfileDetailViewController: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        viewModel.updateAgeRange(minValue: Int(minValue), maxValue: Int(maxValue))
    }
}

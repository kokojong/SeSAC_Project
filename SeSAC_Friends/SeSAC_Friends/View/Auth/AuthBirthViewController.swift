//
//  AuthBirthViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/19.
//

import UIKit
import SnapKit
import Toast

class AuthBirthViewController: UIViewController {

    let mainView = AuthCommonView()
    
    var viewModel = AuthViewModel.shared
    
    let birthPicker = UIDatePicker()
    
    let birthStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    let yearView = BirthView()
    let monthView = BirthView()
    let dayView = BirthView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        monitorNetwork()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitorNetwork()
        
        view.backgroundColor = .white
        
        configViews()
        addViews()
        addConstraints()
        
        mainView.mainButton.addTarget(self, action: #selector(onRequestButtonClicked), for: .touchUpInside)
        birthPicker.addTarget(self, action: #selector(onBirthPickerValueChanged(sender:)), for: .valueChanged)
        
        
        viewModel.birthday.bind { date in
            let birthday = self.viewModel.getBirthdayElements(bitrhday: self.viewModel.birthday.value)
            self.yearView.textField.text = birthday[0]
            self.monthView.textField.text = birthday[1]
            self.dayView.textField.text = birthday[2]
            if date != Date.now {
                self.mainView.mainButton.style = .fill
            } else {
                self.birthPicker.date = .now
            }
        }
    }
    
    func configViews() {
        mainView.mainLabel.text = "생년월일을 입력해주세요"
        mainView.mainTextField.isHidden = true
        mainView.seperator.isHidden = true
        mainView.mainButton.setTitle("다음", for: .normal)
        birthPicker.preferredDatePickerStyle = .wheels
        birthPicker.locale = Locale(identifier: "ko-KR")
        birthPicker.datePickerMode = .date
        birthPicker.timeZone = NSTimeZone.local
        birthPicker.becomeFirstResponder()
        

        
        yearView.textField.text = "1994"
        yearView.label.text = "년"
        monthView.textField.text = "5"
        monthView.label.text = "월"
        dayView.textField.text = "3"
        dayView.label.text = "일"
        
    }
    
    func addViews() {
        self.view.addSubview(birthPicker)
        self.view.addSubview(birthStackView)
        birthStackView.addArrangedSubview(yearView)
        birthStackView.addArrangedSubview(monthView)
        birthStackView.addArrangedSubview(dayView)
       
    }
    
    func addConstraints() {
        birthPicker.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(16)
//            make.bottom.equalTo(self.mainView.mainTextField.snp.bottom)
        }
        
        birthStackView.snp.makeConstraints { make in
            make.bottom.equalTo(mainView.mainButton.snp.top).inset(-60)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(mainView.seperator)
//            make.center.equalToSuperview()
//            make.height.equalTo(100)
//            make.width.equalTo(300)   
        }
    
    }
    
    @objc func onRequestButtonClicked() {
        
        if calculateAge() >= 17 {
            let vc = AuthEmailViewController()
            vc.viewModel = self.viewModel
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            self.view.makeToast("새싹 프렌즈는 만 17세 이상만 이용이 가능합니다.")
        }
        
    }

    @objc func onBirthPickerValueChanged(sender: UIDatePicker) {

        self.viewModel.birthday.value = sender.date
        let birthday = self.viewModel.getBirthdayElements(bitrhday: self.viewModel.birthday.value)
        
        yearView.textField.text = birthday[0]
        monthView.textField.text = birthday[1]
        dayView.textField.text = birthday[2]
        
        mainView.mainButton.style = .fill
        
    }
    
    func calculateAge() -> Int {
        let distanceHour = Calendar.current.dateComponents([.year], from: self.viewModel.birthday.value, to: Date.now).year ?? 0
        
        return distanceHour
    }
}



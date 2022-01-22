//
//  AuthGenderViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/21.
//

import UIKit

class AuthGenderViewController: UIViewController {

    let mainView = AuthCommonView()
    
    let subLabel = MainLabel()
    
    var viewModel: AuthViewModel!
    
    var genderManView = GenderView(type: .inactive)
    
    var genderWomanView = GenderView(type: .inactive)

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        addViews()
        addConstraints()
        configViews()
        
        viewModel.gender.bind { gender in
            switch gender {
            case 0:
                self.genderManView.style = .active
                self.genderWomanView.style = .inactive
            case 1:
                self.genderManView.style = .inactive
                self.genderWomanView.style = .active
            default:
                self.genderManView.style = .inactive
                self.genderWomanView.style = .inactive
                
            }
        }
        
        genderManView.setOnClickListener {
            if self.viewModel.gender.value != 0 {
                self.viewModel.gender.value = 0
            } else {
                self.viewModel.gender.value = 2
            }
        }
        
        genderWomanView.setOnClickListener {
            if self.viewModel.gender.value != 1 {
                self.viewModel.gender.value = 1
            } else {
                self.viewModel.gender.value = 2
            }
        }
 
    }
    
    func addViews() {
        self.view.addSubview(subLabel)
        self.view.addSubview(genderManView)
        self.view.addSubview(genderWomanView)
    }
    
    func addConstraints() {
        subLabel.snp.makeConstraints { make in
            make.centerX.equalTo(mainView.mainLabel)
            make.top.equalTo(mainView.mainLabel.snp.bottom).offset(8)
        }
        
        genderManView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalTo(mainView.mainButton.snp.top).offset(-32)
        }
        
        genderWomanView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(32)
            make.leading.equalTo(genderManView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(mainView.mainButton.snp.top).offset(-32)
            make.width.equalTo(genderManView.snp.width)
        }
    }
    
    func configViews() {
        mainView.mainLabel.text = "성별을 선택해주세요"
        mainView.mainTextField.isHidden = true
        mainView.seperator.isHidden = true
        subLabel.text = "새싹 찾기 기능을 위해 필요해요!"
        mainView.mainButton.setTitle("회원가입", for: .normal)
       
        genderManView.genderImageview.image = UIImage(named: "man")
        genderWomanView.genderImageview.image = UIImage(named: "woman")
        
    }


}

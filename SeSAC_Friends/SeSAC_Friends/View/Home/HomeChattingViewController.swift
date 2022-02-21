//
//  HomeChattingViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/17.
//

import UIKit
import SnapKit
import Then

class HomeChattingViewController: UIViewController, UiViewProtocol {
    
    let resetButton = UIButton().then {
        $0.setTitle("reset", for: .normal)
    }
    
    let mainTableView = UITableView().then {
        $0.backgroundColor = .yellow
    }
    
    let chatView = ChattingView().then {
        $0.textView.text = "메세지를 입력하세요"
        $0.textView.textColor = UIColor.lightGray
    }
    
    // moreButton을 누르면 열리는 뷰
    let moreView = UIView().then {
        $0.isHidden = true
    }
    
    let menuView = MenuView().then {
        $0.backgroundColor = .white
    }
    
    let darkView = UIView().then {
        $0.backgroundColor = .black?.withAlphaComponent(0.5)
    }
    
    var viewModel = HomeViewModel.shared

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        title = "채팅"
        
        addViews()
        addConstraints()
        
        setNavBackArrowButton()
        let moreButton = UIBarButtonItem(image: UIImage(named: "ellipsis.vertical"), style: .done, target: self, action: #selector(onMoreButtonClicked))
        moreButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = moreButton
        
        chatView.textView.delegate = self
        
        resetButton.addTarget(self, action: #selector(onResetButtonClicked), for: .touchUpInside)
        
        
        menuView.reportButton.addTarget(self, action: #selector(reportButtonClicked), for: .touchUpInside)
        menuView.dodgeButton.addTarget(self, action: #selector(dodgeButtonClicked), for: .touchUpInside)
        
    }
    
    func addViews() {
        view.addSubview(mainTableView)
        view.addSubview(resetButton)
        view.addSubview(chatView)
        view.addSubview(moreView)
        moreView.addSubview(menuView)
        moreView.addSubview(darkView)
    }
    
    func addConstraints() {
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(chatView.snp.top)
        }
        
        resetButton.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        chatView.snp.makeConstraints { make in
            make.top.equalTo(mainTableView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
//            make.height.equalTo(chatView.textView.contentSize.height+28)
        }
        
        moreView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(mainTableView)
            make.bottom.equalToSuperview()

        }
        menuView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(11)
            make.height.equalTo(50)
        }
        
        darkView.snp.makeConstraints { make in
            make.top.equalTo(menuView.snp.bottom).offset(11)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    @objc func onResetButtonClicked() {
        print(#function)
        UserDefaults.standard.set(MyStatusCase.normal.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
    }
    
    @objc func onMoreButtonClicked() {
        print(#function)
        moreView.isHidden.toggle()
    }
    
    @objc func reportButtonClicked() {
        print(#function)
        moreView.isHidden.toggle()
        
        let vc = HomeChattingReportViewController()
        vc.modalTransitionStyle = . crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
        
    }
    
    @objc func dodgeButtonClicked() {
        print(#function)
        moreView.isHidden.toggle()
        
        let vc = HomeChattingDodgeViewController()
        vc.modalTransitionStyle = . crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
}

extension HomeChattingViewController: UITextViewDelegate {
    
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

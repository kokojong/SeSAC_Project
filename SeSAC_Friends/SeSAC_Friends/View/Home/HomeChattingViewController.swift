//
//  HomeChattingViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/17.
//

import UIKit

class HomeChattingViewController: UIViewController {
    
    let resetButton = UIButton().then {
        $0.setTitle("reset", for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .brown
        title = "채팅"
        
        resetButton.addTarget(self, action: #selector(onResetButtonClicked), for: .touchUpInside)
        
        view.addSubview(resetButton)
        resetButton.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    @objc func onResetButtonClicked() {
        print(#function)
        UserDefaults.standard.set(MyStatusCase.normal.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

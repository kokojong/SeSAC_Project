//
//  SettingViewController.swift
//  SeSAC_week12
//
//  Created by kokojong on 2021/12/15.
//

import UIKit

class SettingViewController: UIViewController {
    var name: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        print("rootViewController : ",rootViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(name)
        view.backgroundColor = .green
    }
}

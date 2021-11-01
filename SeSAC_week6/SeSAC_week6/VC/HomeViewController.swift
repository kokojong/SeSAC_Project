//
//  HomeViewController.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.items![0].title = NSLocalizedString("homeTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
        self.tabBarController?.tabBar.items![1].title = NSLocalizedString("searchTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
        self.tabBarController?.tabBar.items![2].title = NSLocalizedString("calendarTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
        self.tabBarController?.tabBar.items![3].title = NSLocalizedString("settingTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
        
        title = NSLocalizedString("homeTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
        
    }
    

    @IBAction func onAddButtonClicked(_ sender: UIBarButtonItem) {
        
        // 1. sb
        let sb = UIStoryboard(name: "Content", bundle: nil)
        
        // 2. vc
        let vc = sb.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        // 2-1 navController embed
        let nav = UINavigationController(rootViewController: vc)
        
        // 2-2. present 방식(fullscreen)
        nav.modalPresentationStyle = .fullScreen
        
        // 3. present
        present(nav, animated: true, completion: nil)
        
    }
}

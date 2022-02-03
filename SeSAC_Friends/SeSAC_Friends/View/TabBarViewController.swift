//
//  TabBarViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = .green
        self.tabBar.unselectedItemTintColor = .gray6
        self.tabBar.backgroundColor = .white
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem.image = UIImage(named: "homeGray")
        homeVC.tabBarItem.title = "홈"
        
        let shopVC = UINavigationController(rootViewController: ShopViewController())
        shopVC.tabBarItem.image = UIImage(named: "shopGray")
        shopVC.tabBarItem.title = "새싹샵"
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem.image = UIImage(named: "profileGray")
        profileVC.tabBarItem.title = "내정보"
        
        
        viewControllers = [homeVC, shopVC, profileVC]
    }
    

 
}

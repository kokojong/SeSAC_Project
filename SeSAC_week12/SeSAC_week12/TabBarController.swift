//
//  TabBarController.swift
//  SeSAC_week12
//
//  Created by kokojong on 2021/12/15.
//

import UIKit

// navController, tabbarController
// TabBar, TabBarItem(title, image, selectImage), TintColor
// iOS 13 이상: UITabBarAppearance -> 배경의 컬러를 설정할 때 사용 (버전에 따른 분기처리가 필요)
class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = SettingViewController(nibName: "SettingViewController", bundle: nil)
        firstVC.tabBarItem.title = "setttingVC"
        firstVC.tabBarItem.image = UIImage(systemName: "star")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        let secondVC = SnapDetailViewController()
        secondVC.tabBarItem = UITabBarItem(title: "snapDetailVC", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        // 처음에 third가 안나오는 이유: viewDidLoad에서 해서
        let thirdVC = DetailViewController()
//        thirdVC.title = "title"
        thirdVC.tabBarItem = UITabBarItem(title: "detailVC", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        let thirdNav = UINavigationController(rootViewController: thirdVC) // 임베드
        
        let baeminVC = BaeminViewController()
        baeminVC.tabBarItem = UITabBarItem(title: "Baemin", image: UIImage(systemName: "bicycle"), selectedImage: UIImage(systemName: "bicycle"))
        
        let melonVC = melonViewController()
        melonVC.tabBarItem = UITabBarItem(title: "Melon", image: UIImage(systemName: "music.mic"), selectedImage: UIImage(systemName: "music.mic"))
        
        setViewControllers([firstVC, secondVC, thirdNav, baeminVC, melonVC], animated: true)
        
        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
        appearance.configureWithDefaultBackground()
//        tabBar.backgroundColor = .orange
//        appearance.configureWithTransparentBackground()
//        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .orange
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
    }
}

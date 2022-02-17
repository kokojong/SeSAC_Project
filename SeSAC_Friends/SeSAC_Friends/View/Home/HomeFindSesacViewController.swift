//
//  HomeFindSesacViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/14.
//

import UIKit
import Tabman
import Pageboy

class HomeFindSesacViewController: TabmanViewController {
    
    private var viewControllers = [HomeNearSesacViewController(), HomeRecievedRequestsViewController()]
    
    private let titleList = ["새싹 찾기", "받은 요청"]

    var viewModel = HomeViewModel.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        viewModel.getUserInfo { userinfo, statuscode ,error in
            guard let userinfo = userinfo else {
                return
            }

            self.viewModel.myUserInfo.value = userinfo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "새싹 찾기"
        view.backgroundColor = .yellow
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        setNavBackArrowButton()
        
        let stopSearchBarButton = UIBarButtonItem(title: "찾기중단", style: .done, target: self, action: #selector(onStopSearchBarButtonClicked))
        stopSearchBarButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = stopSearchBarButton
        
        self.dataSource = self
//        let bar = TMBar.ButtonBar()
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize
        bar.layout.contentMode = .fit
        
        // Add to view
        addBar(bar, dataSource: self, at: .top)
        
    }
    
    @objc func onStopSearchBarButtonClicked() {
        
        viewModel.deleteQueue { statuscode, error in
            
            switch statuscode {
            case DeleteQueueStatusCodeCase.success.rawValue:
                UserDefaults.standard.set(MyStatusCase.normal.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                self.navigationController?.pushViewController(HomeHobbyViewController(), animated: true)
            case DeleteQueueStatusCodeCase.matched.rawValue:
                self.view.makeToast("누군가와 취미를 함께하기로 약속하셨어요!")
                UserDefaults.standard.set(MyStatusCase.matched.rawValue, forKey: UserDefaultKeys.myStatus.rawValue)
                print(self.viewModel.myStatus.value)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.pushViewController(HomeChattingViewController(), animated: true)
                }
               
            default:
                self.view.makeToast("오류가 발생했습니다. 잠시 후 다시 시도해주세요.")
                
            }
        }
        
    }
    
    

  
}

extension HomeFindSesacViewController: PageboyViewControllerDataSource, TMBarDataSource  {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        print(viewControllers[index])
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = titleList[index]
        return TMBarItem(title: title)
    }
    
    
}

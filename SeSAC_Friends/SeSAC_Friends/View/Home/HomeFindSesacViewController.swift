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
        print(#function)
        
        viewModel.deleteQueue { statuscode, error in
            self.view.makeToast("\(statuscode)")
            
            
            switch statuscode {
            case QueueStatusCodeCase.success.rawValue:
                UserDefaults.standard.set(0, forKey: UserDefaultKeys.myStatus.rawValue)
                
            default:
                print(statuscode)
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

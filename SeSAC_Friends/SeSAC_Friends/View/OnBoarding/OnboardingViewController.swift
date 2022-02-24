//
//  OnboardingViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/24.
//

import UIKit
import SnapKit

let onboardingView1 = OnboardingView()
let onboardingView2 = OnboardingView()
let onboardingView3 = OnboardingView()

class OnboardingViewController: UIPageViewController {
    
    var pages: [UIViewController] = []
    let pageControl = UIPageControl()
    let initialPage = 0
    
    let mainButton = MainButton(type: .fill)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        let page1 = ViewController1()
        let page2 = ViewController2()
        let page3 = ViewController3()
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
        mainButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(106)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        mainButton.setTitle("시작하기", for: .normal)
        mainButton.tintColor = .white
        view.addSubview(mainButton)
        mainButton.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
        }
        
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func nextTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        goToNextPage()
    }
    
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else {
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: AuthRequestViewController())
            windowScene.windows.first?.makeKeyAndVisible()
            
            return
        }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    
}

extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return nil             // 처음에서 뒤로 못 넘어가게
        } else {
            return pages[currentIndex - 1]  // go previous
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
            return nil             // 마지막이니까 못넘어가게
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
    

    
}

class ViewController1: UIViewController {
    
    override func loadView() {
        self.view = onboardingView1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView1.imageView.image = UIImage(named: "onboarding_img1")
        onboardingView1.titleLabel.text = "위치 기반으로 빠르게\n주위 친구를 확인"
    }
}

class ViewController2: UIViewController {
    override func loadView() {
        self.view = onboardingView2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView2.imageView.image = UIImage(named: "onboarding_img2")
        onboardingView2.titleLabel.text = "관심사가 같은 친구를\n찾을 수 있어요"
    }
}

class ViewController3: UIViewController {
    override func loadView() {
        self.view = onboardingView3
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView3.imageView.image = UIImage(named: "onboarding_img3")
        onboardingView3.titleLabel.text = "SeSAC Friends"
    }
}

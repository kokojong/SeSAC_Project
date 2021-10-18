//
//  ViewController.swift
//  SeSAC_week3_MyDiary
//
//  Created by kokojong on 2021/10/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        setBackgroundColor() // extension
        
        
    }

    // present - dismiss
    @IBAction func memoButtonClicked(_ sender: UIButton) {
        // 1. 스토리보드 특정
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 스토리보드 안에 많은 뷰 컨트롤러 중 전환하고자 하는 뷰 컨트롤러를 가져오기
        let vc = storyboard.instantiateViewController(withIdentifier: "MemoTableViewController") as! MemoTableViewController
    
        // 2-1. 네비게이션 컨트롤러 임베드하기
        let nav = UINavigationController(rootViewController: vc)
        
        // option
//        vc.modalTransitionStyle = .flipHorizontal
        nav.modalPresentationStyle = .fullScreen
//        nav.modalTransitionStyle = .partialCurl //이거는 풀스크린에서만 가능 -> 돌아갈 수 없어서 닫기 버튼을 만들어줘야 함
        
        // 3. Present
        self.present(nav, animated: true, completion: nil)
        
        // dismiss
//        self.dismiss(animated: true, completion: nil)
      
    }
    
    // push - pop
    @IBAction func boxOfficeButtonClicked(_ sender: UIButton) {
        
        // 1. 스토리보드 특정
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 스토리보드 안에 많은 뷰 컨트롤러 중 전환하고자 하는 뷰 컨트롤러를 가져오기
        let vc = storyboard.instantiateViewController(withIdentifier: "BoxOfficeTableViewController") as! BoxOfficeTableViewController
        
        // 동일한 스토리보드 안에 있다면 아래와 같이 가능하다(위에 storyboard 생략가능)
        // vc = self.storyboard
        
        // pass data 3
        vc.titleSpace = "박스오피스"
        
        
        
        // push
        // 네이게이션 컨트롤러가 없다면 Nil
        self.navigationController?.pushViewController(vc, animated: true)
        
        // pop
//
    
        
    }
}


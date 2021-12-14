//
//  BaeminViewController.swift
//  SeSAC_week12
//
//  Created by kokojong on 2021/12/14.
//

import UIKit

class BaeminViewController: UIViewController {
    
    let blockView1 = BlockView() // 배달
    let blockView2 = BlockView() // 배민1
    let blockView3 = BlockView() // 포장
    let blockView4 = BlockView() // B마트
    let blockView5 = BlockView() // 쇼핑라이브
    let blockView6 = BlockView() // 선물하기
    let blockView7 = BlockView() // 전국별미
    let blockView8 = BlockView() // 배너광고

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        [blockView1, blockView2, blockView3, blockView4, blockView5, blockView6, blockView7, blockView8].forEach { blockView in
            blockView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(blockView)
        }
        
        setBlockView1Constraint()
        setBlockView2Constraint()
        setBlockView3Constraint()
        setBlockView4Constraint()
        setBlockView5Constraint()
        setBlockView6Constraint()
        setBlockView7Constraint()
        setBlockView8Constraint()
        
    }
    
    func setBlockView1Constraint() {
        
        blockView1.titleLabel.text = "배달"
        blockView1.subtitleLabel.text = "세상은 넓고\n맛집은 많다"
        NSLayoutConstraint.activate([
            blockView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            blockView1.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            blockView1.trailingAnchor.constraint(equalTo: blockView2.leadingAnchor, constant: -20),
            blockView1.heightAnchor.constraint(equalTo: blockView1.widthAnchor),
            blockView1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -30)
         ])
    }
    
    func setBlockView2Constraint() {
        
        blockView2.titleLabel.text = "배민1"
        blockView2.subtitleLabel.text = "배민원, 한 번에\n한 집만 빠르게"
        NSLayoutConstraint.activate([
            blockView2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
//            blockView2.leadingAnchor.constraint(equalTo: blockView1.trailingAnchor,constant: 20), // 위에서 잡아준거라서 없어도 된다
            blockView2.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            blockView2.heightAnchor.constraint(equalTo: blockView2.widthAnchor),
            blockView2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -30)
        ])
    }
    
    func setBlockView3Constraint() {
        
        blockView3.titleLabel.text = "포장"
        blockView3.subtitleLabel.text = "가까운 가게는 직접 가지러 가세요"
        NSLayoutConstraint.activate([
            blockView3.topAnchor.constraint(equalTo: blockView1.bottomAnchor, constant: 20),
            blockView3.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            blockView3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            blockView3.heightAnchor.constraint(equalTo: blockView1.heightAnchor, multiplier: 0.5, constant: 0)
            
         ])
    }
    
    func setBlockView4Constraint() {
        
        blockView4.titleLabel.text = "B마트"
        blockView4.subtitleLabel.text = "장보기도\n즉시배달"
        NSLayoutConstraint.activate([
            blockView4.topAnchor.constraint(equalTo: blockView3.bottomAnchor, constant: 20),
            blockView4.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            blockView4.trailingAnchor.constraint(equalTo: blockView5.leadingAnchor, constant: -20),
            blockView4.heightAnchor.constraint(equalTo: blockView3.heightAnchor, multiplier: 1.2, constant: 0),
            blockView4.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -30)
            
            
         ])
    }
    
    func setBlockView5Constraint() {
        
        blockView5.titleLabel.text = "쇼핑라이브"
        blockView5.subtitleLabel.text = "비비큐! 총\n200원 혜택"
        NSLayoutConstraint.activate([
            blockView5.topAnchor.constraint(equalTo: blockView3.bottomAnchor, constant: 20),
            blockView5.leadingAnchor.constraint(equalTo: blockView4.trailingAnchor, constant: 20),
            blockView5.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            blockView5.heightAnchor.constraint(equalTo: blockView3.heightAnchor, multiplier: 1.2, constant: 0),
            blockView5.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -30)
            
         ])
    }
    
    func setBlockView6Constraint() {
        
        blockView6.titleLabel.text = "선물하기"
        blockView6.subtitleLabel.text = "배민 상품권\n선물해 보세요"
        NSLayoutConstraint.activate([
            blockView6.topAnchor.constraint(equalTo: blockView4.bottomAnchor, constant: 20),
            blockView6.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            blockView6.trailingAnchor.constraint(equalTo: blockView7.leadingAnchor, constant: -20),
            blockView6.heightAnchor.constraint(equalTo: blockView3.heightAnchor, multiplier: 1.2, constant: 0),
            blockView6.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -30)
            
         ])
    }
    
    func setBlockView7Constraint() {
        
        blockView7.titleLabel.text = "전국별미"
        blockView7.subtitleLabel.text = "동네 맛집을\n넘어서"
        NSLayoutConstraint.activate([
            blockView7.topAnchor.constraint(equalTo: blockView4.bottomAnchor, constant: 20),
            blockView7.leadingAnchor.constraint(equalTo: blockView6.trailingAnchor, constant: 20),
            blockView7.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            blockView7.heightAnchor.constraint(equalTo: blockView3.heightAnchor, multiplier: 1.2, constant: 0),
            blockView7.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -30)
            
         ])
    }
    
    func setBlockView8Constraint() {
        
        blockView8.titleLabel.text = "배너 광고고고"
        blockView8.subtitleLabel.text = "광고입니다아아아"
        NSLayoutConstraint.activate([
            blockView8.topAnchor.constraint(equalTo: blockView6.bottomAnchor, constant: 20),
            blockView8.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            blockView8.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            blockView8.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            
         ])
    }
    



}

//
//  DetailViewController.swift
//  SeSAC_week12
//
//  Created by kokojong on 2021/12/13.
//

import UIKit

class DetailViewController: UIViewController {
    
//    let bannerView = BannerView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let actButton = MainActivateButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tabBarItem.title = "third"
//        tabBarItem.image = UIImage(systemName: "person")
//        tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        view.backgroundColor = .white
        
//        bannerView.frame = CGRect(x: 30, y: 100, width: UIScreen.main.bounds.width - 60, height: 120)
//        view.addSubview(bannerView)
        
        // 한번에 처리
        [titleLabel, subtitleLabel, actButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        setTitleLabelConstraints()
        setSubtitleLableConstraints()
        setActButtonConstraints()
        
        func setActButtonConstraints() {
            view.addSubview(actButton)
            actButton.translatesAutoresizingMaskIntoConstraints = false
            
            // 여러개를 active하게 만듬
            NSLayoutConstraint.activate([
                actButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                actButton.widthAnchor.constraint(equalToConstant: 300),
                actButton.heightAnchor.constraint(equalToConstant: 50),
                actButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
            
            
        }
        
        func setTitleLabelConstraints() {
            titleLabel.text = "관심있는 회사를\n3개 선택해주세요"
            titleLabel.backgroundColor = .lightGray
            titleLabel.font = .boldSystemFont(ofSize: 24)
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            
            view.addSubview(titleLabel)
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
//            titleLabel.frame = CGRect(x: 100, y: 100, width: UIScreen.main.bounds.width - 200, height: 80)
            // NSLayoutConstraints
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 40).isActive = true
            NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -40).isActive = true
            NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 80).isActive = true
            
            
        }
        
        func setSubtitleLableConstraints() {
            subtitleLabel.text = "맞춤 정보를 알려드려요"
            subtitleLabel.backgroundColor = .darkGray
            subtitleLabel.font = .systemFont(ofSize: 15)
            subtitleLabel.textAlignment = .center
            subtitleLabel.numberOfLines = 0
            
            view.addSubview(subtitleLabel)
            
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let toptop = NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 30)
//            NSLayoutConstraint(item: subtitleLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 40).isActive = true
//            NSLayoutConstraint(item: subtitleLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -40).isActive = true
            let centerX = NSLayoutConstraint(item: subtitleLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
            let height = NSLayoutConstraint(item: subtitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
            let width = NSLayoutConstraint(item: subtitleLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.7, constant: 0)
            
            view.addConstraints([toptop,centerX,height,width])
        }
        
    }
    



}

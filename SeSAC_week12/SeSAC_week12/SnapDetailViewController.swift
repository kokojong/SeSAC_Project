//
//  SnapDetailViewController.swift
//  SeSAC_week12
//
//  Created by kokojong on 2021/12/14.
//

import UIKit
import SnapKit

class SnapDetailViewController: UIViewController {

    let actButton: MainActivateButton = {
        let button = MainActivateButton()
        button.setTitle("tititi", for: .normal)
        button.addTarget(self, action: #selector(actButtonClicked), for: .touchUpInside)
        return button
    }()
    let moneyLabel: UILabel = {
       let label = UILabel()
        label.backgroundColor = .yellow
        label.text = "100원"
        return label
    }()
    let descriptionLabel = UILabel()
    
    let redView = UIView()
    let blueView = UIView()
    
    let firstSquareBoxView: SquareBoxView = {
        let view = SquareBoxView()
        view.label.text = "토스뱅크"
        view.imageView.image = UIImage(systemName: "trash.fill")
        return view
    
    }()
    let secondSquareBoxView: SquareBoxView = {
        let view = SquareBoxView()
        view.label.text = "토스증권"
        view.imageView.image = UIImage(systemName: "chart.xyaxis.line")
        return view
    
    }()
    let thirdSquareBoxView: SquareBoxView = {
        let view = SquareBoxView()
        view.label.text = "고객센터"
        view.imageView.image = UIImage(systemName: "person")
        return view
    
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    @objc func actButtonClicked() {
//        let vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        let vc = SettingViewController()
        vc.name = "kokojong"
//        present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        print("rootViewController : ",rootViewController)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // StackView
        view.addSubview(stackView)
        stackView.addArrangedSubview(firstSquareBoxView)
        stackView.addArrangedSubview(secondSquareBoxView)
        stackView.addArrangedSubview(thirdSquareBoxView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalTo(view)
//            $0.width.equalTo(view)
//            $0.leading.equalTo(view)
            $0.width.equalTo(view.snp.width).multipliedBy(0.8/1.0).inset(20)
            $0.height.equalTo(80)
        }
        
        firstSquareBoxView.alpha = 0
        secondSquareBoxView.alpha = 0
        thirdSquareBoxView.alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.firstSquareBoxView.alpha = 1
            
        }
        
        UIView.animate(withDuration: 1) {
            self.secondSquareBoxView.alpha = 1
        } completion: { bool in
            UIView.animate(withDuration: 1) {
                self.thirdSquareBoxView.alpha = 1
            }
        }

        
        
        
        view.backgroundColor = .white
        
        // 익명 함수로 정의하는것으로 변경
//        actButton.addTarget(self, action: #selector(actButtonClicked), for: .touchUpInside)
        
        [actButton, moneyLabel, descriptionLabel,redView].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
            // SnapKit이라서 안해도 된다
            view.addSubview($0)
        }
        
//        moneyLabel.backgroundColor = .yellow
//        moneyLabel.text = "10원"
        
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        actButton.snp.makeConstraints {
//            $0.leadingMargin.equalTo(view)
            $0.trailingMargin.equalTo(view)
            $0.leading.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.1)
        }
        
        redView.backgroundColor = .red
        redView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(200)
//            make.bottom.equalTo(50) // 4면을 하고 아래만 한다면 될거야 -> 어림도 없지 암!(두가지 레이아웃이 충돌 -> 앱이 죽지는 x)
        }
        // 이걸 대응하는게 update
        redView.snp.updateConstraints { make in
            make.bottom.equalTo(-500)
        }
        
        redView.addSubview(blueView)
        blueView.backgroundColor = .blue
        blueView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(50)
        }
        
        
        
        
    }
    



}

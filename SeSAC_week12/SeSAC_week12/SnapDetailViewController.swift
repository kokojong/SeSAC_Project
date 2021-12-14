//
//  SnapDetailViewController.swift
//  SeSAC_week12
//
//  Created by kokojong on 2021/12/14.
//

import UIKit
import SnapKit

class SnapDetailViewController: UIViewController {

    let actButton = MainActivateButton()
    let moneyLabel: UILabel = {
       let label = UILabel()
        label.backgroundColor = .yellow
        label.text = "100원"
        return label
    }()
    let descriptionLabel = UILabel()
    
    let redView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
            make.edges.equalToSuperview().inset(100)
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

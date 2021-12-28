//
//  SignViewModel.swift
//  SeSAC_week13
//
//  Created by kokojong on 2021/12/22.
//

import Foundation
import UIKit

class SignViewModel {
    
    var navigationTitle: String = "nav title"
    var buttonTitle: String = "가입하기"
    
    func didTapButton(completion: @escaping () -> Void) {
        completion()
    }
    
    var text: String = "" {
        didSet {
            let count = text.count
            let value = count >= 100 ? "작성할 수 없습니다" : "\(count)/100"
            let color: UIColor = count >= 100 ? .red : .blue
            
            listener?(value, color)
        }
    }
    
    var listener: ((String, UIColor) -> Void)?
    
    func bind(listener: @escaping (String, UIColor) -> Void) {
        self.listener = listener
    }
    
}

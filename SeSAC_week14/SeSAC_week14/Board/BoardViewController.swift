//
//  BoardViewController.swift
//  SeSAC_week14
//
//  Created by kokojong on 2021/12/28.
//

import UIKit
import SnapKit

class BoardViewController: UIViewController {
    
    let mainView = BoardView()
    
    let viewModel = BoardViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getBoards()
        
        view.backgroundColor = .white
        
        viewModel.username.bind { text in
            self.mainView.usernameLabel.text = text
        }
        viewModel.email.bind { text in
            self.mainView.emailLabel.text = text
        }
        viewModel.text.bind { text in
            self.mainView.textLabel.text = text
        }
        viewModel.uploaddate.bind { text in
            self.mainView.uploadDateLabel.text = text
        }
    }
    
    
    
}

//
//  SignInViewController.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/02.
//

import UIKit

class SignInViewController: UIViewController {
    
    let signInView = SignInView()
    
    override func loadView() {
        self.view = signInView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

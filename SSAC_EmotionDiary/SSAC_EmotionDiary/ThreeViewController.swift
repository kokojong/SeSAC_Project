//
//  ThreeViewController.swift
//  SSAC_EmotionDiary
//
//  Created by kokojong on 2021/10/05.
//

import UIKit

class ThreeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self,#function)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self, #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(self, #function)
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

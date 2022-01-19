//
//  ViewController.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var welcomLabel: UILabel!
    @IBOutlet weak var backupRestoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
         S-Core Dream
         ---> S-CoreDream-2ExtraLight
         ---> S-CoreDream-5Medium
         ---> S-CoreDream-9Black
         */
        for family in UIFont.familyNames {
            print(family)
            
            for sub in UIFont.fontNames(forFamilyName: family) {
                
                print("---> \(sub)")
                
            }
        }
        
//        welcomLabel.text = "반가워요우~"
        // size: 11~20
//        welcomLabel.font = UIFont(name: "S-CoreDream-9Black", size: 17)
//        welcomLabel.text = "welcome_text".localized
//        welcomLabel.text = NSLocalizedString("welcome_text", comment: "")
        welcomLabel.text = LocalizableStrings.welcomeText.rawValue
        welcomLabel.text = LocalizableStrings.welcomeText.localized
        welcomLabel.font = UIFont().mainBlack
     
//        backupRestoreLabel.text = NSLocalizedString("data_backup", tableName: "Settings", bundle: .main, value: "", comment: "")
        backupRestoreLabel.text = LocalizableStrings.settingText.localized
        backupRestoreLabel.text = NSLocalizedString("homeTitle", tableName: "TabBarSetting", bundle: .main, value: "", comment: "")
        welcomLabel.text = NSLocalizedString("homeTitle", comment: "")
        
    }


}


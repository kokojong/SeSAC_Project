//
//  DetailViewController.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/03.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    let localRealm = try! Realm()
    
    var task: UserDiary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = task.diaryTitle
        dateLabel.text = "\(task.diaryDate)"
        contentTextView.text = task.diaryContent
        detailImageView.image = loadImageFromDocumentDirectory(imageName: "\(task._id).jpg")
        

    }
    
    // 도큐먼트 폴더 경로 -> 이미지 찾기 -> UIImage -> UIImageView
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        
        return nil
    }
    

    

}

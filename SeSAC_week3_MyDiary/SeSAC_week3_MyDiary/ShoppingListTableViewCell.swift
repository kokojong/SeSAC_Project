//
//  ShoppingListTableViewCell.swift
//  SeSAC_week3_MyDiary
//
//  Created by kokojong on 2021/10/13.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {

    @IBOutlet weak var shoppingListLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shoppingListLabel.numberOfLines = 0
        checkBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        bookmarkButton.setImage(UIImage(systemName: "star"), for: .normal)
        
//        checkBoxButton.setImage(UIImage.init(named: "heart"), for: .normal)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onCheckBoxButtonClicked(_ sender: UIButton) {
        
        // 이미지를 바꾸려고 했는데 실패함 ㅜ (한번 돌아오면 바뀌질 않네여..)
        if sender.image(for: .normal) == UIImage(systemName: "checkmark.square") {
//            sender.setImage(UIImage(named: "checkmark.square.fill"), for: .normal)
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
//            sender.image(for: .normal) = UIImage(named: "checkmark.square.fill")
            
            print("checked")
        } else {
//            sender.setImage(UIImage(named: "checkmark.square"), for: .normal)
            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            print("unchecked")
         
        }
        
        
    }
    
    @IBAction func onbookmarkButtonClicked(_ sender: UIButton) {
        
        if sender.image(for: .normal) == UIImage(systemName: "star") {
//            sender.setImage(UIImage(named: "checkmark.square.fill"), for: .normal)
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
//            sender.image(for: .normal) = UIImage(named: "checkmark.square.fill")
            
            print("marked")
        } else if sender.image(for: .normal) == UIImage(systemName: "star.fill"){
//            sender.setImage(UIImage(named: "checkmark.square"), for: .normal)
            sender.setImage(UIImage(systemName: "star"), for: .normal)
            print("unmarked")
         
        }
       
    }
}

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
        
//        checkBoxButton.setImage(UIImage.init(named: "heart"), for: .normal)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onCheckBoxButtonClicked(_ sender: UIButton) {
        
        if sender.image(for: .normal) == UIImage(named: "checkmark.square"){
            sender.setImage(UIImage(named: "checkmark.square.fill"), for: .normal)
//            sender.image(for: .normal) = UIImage(named: "checkmark.square.fill")
            
            print("same")
        } else {
            sender.setImage(UIImage(named: "checkmark.square"), for: .normal)
            print("is not same")
        }
        
        
    }
    
    @IBAction func onbookmarkButtonClicked(_ sender: UIButton) {
        
       
    }
}

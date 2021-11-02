//
//  ShoppingListTableViewCell.swift
//  SeSAC_week6_ShoppingList
//
//  Created by kokojong on 2021/11/02.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    static let identifier = "ShoppingListTableViewCell"
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var bookMarkButton: UIButton!
    @IBOutlet weak var shoppingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

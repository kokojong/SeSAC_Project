//
//  ResultTableViewCell.swift
//  SeSAC_Motto
//
//  Created by kokojong on 2021/11/20.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    static let identifier = "ResultTableViewCell"


    @IBOutlet weak var mottoDrawNoLabel: UILabel!
    @IBOutlet weak var winDrawNoLabel: UILabel!
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var numbersStackView: UIStackView!
    @IBOutlet weak var winAmountLabel: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameLabel.text = "A"
    }
    
}

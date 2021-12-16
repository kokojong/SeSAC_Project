//
//  LottoTableViewCell.swift
//  SeSAC_Motto
//
//  Created by kokojong on 2021/11/25.
//

import UIKit

class LottoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var numbersStackView: UIStackView!
    
    static let identifier = "LottoTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

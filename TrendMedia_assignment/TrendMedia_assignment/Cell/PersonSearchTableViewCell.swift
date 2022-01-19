//
//  PersonSearchTableViewCell.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/31.
//

import UIKit

class PersonSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    static let identifier = "PersonSearchTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

}

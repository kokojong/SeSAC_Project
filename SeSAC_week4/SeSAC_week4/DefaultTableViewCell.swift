//
//  DefaultTableViewCell.swift
//  SeSAC_week4
//
//  Created by kokojong on 2021/10/18.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {
    
    static let identifier = "DefaultTableViewCell"

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  CastTableViewCell.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/16.
//

import UIKit

class CastTableViewCell: UITableViewCell {
    
    static let identifier = "CastTableViewCell"

    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

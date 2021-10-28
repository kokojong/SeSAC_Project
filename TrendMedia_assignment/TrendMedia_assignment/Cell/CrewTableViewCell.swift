//
//  CrewTableViewCell.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/28.
//

import UIKit

class CrewTableViewCell: UITableViewCell {

    static let identifier = "CrewTableViewCell"
    
    @IBOutlet weak var crewImageView: UIImageView!
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

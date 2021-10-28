//
//  OverviewTableViewCell.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/19.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var overviewButton: UIButton!
    
    static let identifier = "OverviewTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        overviewButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }

    
}

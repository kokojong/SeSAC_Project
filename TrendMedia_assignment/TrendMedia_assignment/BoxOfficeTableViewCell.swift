//
//  BoxOfficeTableViewCell.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/26.
//

import UIKit

class BoxOfficeTableViewCell: UITableViewCell {

    static let identifier = "BoxOfficeTableViewCell"
    
    @IBOutlet weak var movieRankLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



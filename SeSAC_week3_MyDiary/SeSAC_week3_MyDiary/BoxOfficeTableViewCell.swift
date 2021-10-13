//
//  BoxOfficeTableViewCell.swift
//  SeSAC_week3_MyDiary
//
//  Created by kokojong on 2021/10/13.
//

import UIKit

class BoxOfficeTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageVIew: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

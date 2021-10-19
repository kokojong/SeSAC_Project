//
//  BookCollectionViewCell.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/19.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    static let identifier = "BookCollectionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

//
//  MainCollectionViewCell.swift
//  SeSAC_week4
//
//  Created by kokojong on 2021/10/19.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainCollectionViewCell"
    
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

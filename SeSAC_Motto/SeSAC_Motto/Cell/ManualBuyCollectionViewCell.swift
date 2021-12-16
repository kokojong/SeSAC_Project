//
//  ManualBuyCollectionViewCell.swift
//  SeSAC_Motto
//
//  Created by kokojong on 2021/11/22.
//

import UIKit

class ManualBuyCollectionViewCell: UICollectionViewCell {

    static let identifier = "ManualBuyCollectionViewCell"
    
    @IBOutlet weak var numberLabel: UILabel!
    
    override var isSelected: Bool{
        didSet {
            if isSelected {
                numberLabel.textColor = .white
                self.backgroundColor = .myOrange
            } else {
                numberLabel.textColor = .lightGray
                self.backgroundColor = .clear
            }


        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

}

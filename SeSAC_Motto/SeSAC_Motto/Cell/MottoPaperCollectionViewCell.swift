//
//  MottoPaperCollectionViewCell.swift
//  SeSAC_Motto
//
//  Created by kokojong on 2021/11/20.
//

import UIKit

class MottoPaperCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MottoPaperCollectionViewCell"

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var gameALabel: UILabel!
    @IBOutlet weak var gameBLabel: UILabel!
    @IBOutlet weak var gameCLabel: UILabel!
    @IBOutlet weak var gameDLabel: UILabel!
    @IBOutlet weak var gameELabel: UILabel!
    
    @IBOutlet weak var ALabel: UILabel!
    @IBOutlet weak var BLabel: UILabel!
    @IBOutlet weak var CLabel: UILabel!
    @IBOutlet weak var DLabel: UILabel!
    @IBOutlet weak var ELabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        gameALabel.text = ""
        gameBLabel.text = ""
        gameCLabel.text = ""
        gameDLabel.text = ""
        gameELabel.text = ""
        
    }

}

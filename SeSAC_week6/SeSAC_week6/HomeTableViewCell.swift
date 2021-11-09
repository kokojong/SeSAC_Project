//
//  HomeTableViewCell.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/08.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identiifer = "HomeTableViewCell"
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var collectionVIew: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        collectionVIew.delegate = self
//        collectionVIew.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  SearchTableViewCell.swift
//  SeSAC_week6
//
//  Created by kokojong on 2021/11/01.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
    }
    
    func configureCell(row: UserDiary) {
        
        titleLabel.text = row.diaryTitle
        titleLabel.font = UIFont().mainBlack
        
        contentLabel.text = row.diaryContent
      
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        dateLabel.text = format.string(from: row.diaryDate)
        
    }

}

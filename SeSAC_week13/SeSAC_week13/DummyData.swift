//
//  DummyData.swift
//  SeSAC_week13
//
//  Created by kokojong on 2021/12/21.
//

import UIKit

class DummyViewModel {
    var data: [String] = Array(repeating: "테스트", count: 100)
    
}

extension DummyViewModel: UITableViewCellRepresentable {
    
    var numberOfSection: Int {
        return 1
    }
    
    var numberOfRowsInSection: Int {
        return data.count
    }
    
    var heightOfRowAt: CGFloat {
        return 50
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "ttt"
        return cell
    }
}

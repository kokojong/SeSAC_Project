//
//  UITableViewCellRepresenable.swift
//  SeSAC_week13
//
//  Created by kokojong on 2021/12/21.
//

import UIKit

protocol UITableViewCellRepresentable {
    var numberOfSection: Int { get }
    var numberOfRowsInSection: Int { get }
    var heightOfRowAt: CGFloat { get }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

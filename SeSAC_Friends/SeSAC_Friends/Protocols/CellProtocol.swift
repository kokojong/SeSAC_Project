//
//  CellProtocol.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/20.
//

import Foundation
import UIKit

//protocol CellReusable {
//    static var reuseIdentifier: String { get }
//}
//
//extension UITableViewCell: CellReusable {
//
//    static var reuseIdentifier: String {
//        return String(describing: self)
//    }
//
//}

protocol CellReusable {
    static var reuseIdentifier: String { get }
}

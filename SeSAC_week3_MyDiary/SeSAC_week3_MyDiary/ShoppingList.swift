//
//  ShoppingList.swift
//  SeSAC_week3_MyDiary
//
//  Created by kokojong on 2021/10/14.
//

import Foundation

enum CheckBox : Int {
    case unchecked = 0, checked = 1
    
    var result : Int {
        switch self {
        case .unchecked:
            return 0
        case .checked:
            return 1
        }
    }
    
}

enum BookMark : Int {
    case unmarked = 0, marked = 1
    
    var result : Int{
        switch self {
        case .unmarked:
            return 0
        case .marked:
            return 1
        }
    }
    
}


struct ShoppingList {
    var content : String
    var checkbox : Int
    var bookmark : Int
    
}

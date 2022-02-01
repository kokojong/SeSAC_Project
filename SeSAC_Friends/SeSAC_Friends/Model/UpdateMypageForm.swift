//
//  UpdateMypageFrom.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/02/01.
//

import Foundation

struct UpdateMypageForm: Encodable {
    let searchable: Int
    let ageMin: Int
    let ageMax: Int
    let gender: Int
    let hobby: String
}

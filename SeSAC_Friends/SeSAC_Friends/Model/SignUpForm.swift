//
//  SignUpForm.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/22.
//

import Foundation

struct SignUpForm: Encodable {
    let phoneNumber: String
    var FCMtoken: String
    let nick: String
    let email: String
    let birth: Date
    var gender: Int
}

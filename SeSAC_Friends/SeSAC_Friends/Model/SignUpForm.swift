//
//  SignUpForm.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/22.
//

import Foundation

struct SignUpForm: Encodable {
    let phoneNumber, FCMtoken, nick, email: String
    let birth : Date
    let gender: Int
}

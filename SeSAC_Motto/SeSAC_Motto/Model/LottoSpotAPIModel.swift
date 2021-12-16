//
//  LottoSpotAPIModel.swift
//  SeSAC_Motto
//
//  Created by kokojong on 2021/11/19.
//


import Foundation

struct LottoSpotAPIModel {
    var currentCount: Int
    var matchCount: Int
    var page: Int
    var perPage: Int
    var totalCount: Int
    var data: [LottoSpot]
    
}

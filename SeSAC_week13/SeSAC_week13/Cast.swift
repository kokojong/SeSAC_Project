//
//  Cast.swift
//  SeSAC_week13
//
//  Created by kokojong on 2021/12/21.
//

import Foundation

struct Cast: Codable {
    let peopleListResult: PeopleListResult
}

// MARK: - PeopleListResult
struct PeopleListResult: Codable {
    let totCnt: Int
    let peopleList: [PeopleList]
    let source: String
}

// MARK: - PeopleList
struct PeopleList: Codable {
    let peopleCD, peopleNm, peopleNmEn: String
//    let peopleNmEn: PeopleNmEn
    let repRoleNm, filmoNames: String

    enum CodingKeys: String, CodingKey {
        case peopleCD = "peopleCd"
        case peopleNm, peopleNmEn, repRoleNm, filmoNames
    }
}

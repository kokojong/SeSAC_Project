//
//  TVShow.swift
//  SeSAC_week13_Drama
//
//  Created by kokojong on 2021/12/29.
//

import Foundation

// MARK: - Drama
struct TVShow: Codable {
    let page: Int
    let results: [Result]
    let totalResults, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct Result: Codable {
    let posterPath: String
    let popularity: Double
    let id: Int
    let backdropPath: String
    let voteAverage: Double
    let overview, firstAirDate: String
    let originCountry: [String]
    let genreIDS: [Int]
    let originalLanguage: String
    let voteCount: Int
    let name, originalName: String

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case popularity, id
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
    }
}

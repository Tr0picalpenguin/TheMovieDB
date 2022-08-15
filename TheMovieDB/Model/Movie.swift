//
//  Movie.swift
//  TheMovieDB
//
//  Created by Scott Cox on 8/9/22.
//

import Foundation

struct MovieDictionary: Decodable {
    let page: Int
    let results: [ResultsDictionary]
}

struct ResultsDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case adult
        case title
        case overview
        case posterPath = "poster_path"
        case rating = "vote_average"
        case releaseDate = "release_date"
    }
    let adult: Bool
    let title: String
    let overview: String
    let posterPath: String?
    let rating: Double
    let releaseDate: String
}

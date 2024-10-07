//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Nevin Özkan on 5.10.2024.
//

import Foundation


struct MovieResponse: Decodable {
    let dates: Dates
    let page: Int
    let results: [Movie]
   
    private enum CodingKeys: String, CodingKey {
        case dates
        case page
        case results
    }
}

struct Dates: Decodable {
    let maximum: String
    let minimum: String

   
    private enum CodingKeys: String, CodingKey {
        case maximum
        case minimum
    }
}

struct Movie: Decodable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let imdbID: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case imdbID = "imdb_id"
    }
}


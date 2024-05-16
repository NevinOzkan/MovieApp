//
//  Movie.swift
//  MovieApp
//
//  Created by Nevin Özkan on 10.05.2024.
//

import Foundation

struct Movies: Decodable {
    let results: [Movie]
}

struct MoviesResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    var imageURL: URL?
}

struct Movie: Decodable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
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
}



//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Nevin Özkan on 7.10.2024.
//

import Foundation

class DetailViewModel {
    
    var movie: Movie?
    private let apiService = APIService()
  
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        apiService.fetchMovieDetails(movieID: movieID) { result in
            switch result {
            case .success(let movie):
                print("API'den gelen film verisi: \(movie)")
                self.movie = movie
                completion(.success(movie))
            case .failure(let error):
                print("Geçersiz")
                completion(.failure(error))
            }
        }
    }
}

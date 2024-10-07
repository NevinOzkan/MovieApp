//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Nevin Özkan on 5.10.2024.
//

import Foundation


class HomeViewModel {
    
    private let apiService = APIService()
    
    func fetchUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        apiService.fetchUpcomingMovies(page: 1) { result in
            completion(result)
        }
    }
    
    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        apiService.fetchNowPlayingMovies(page: 1) { result in
            completion(result)
        }
    }
}

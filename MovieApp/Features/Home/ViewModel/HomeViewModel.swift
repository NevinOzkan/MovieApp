//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Nevin Özkan on 5.10.2024.
//

import Foundation


class HomeViewModel {
    
    private let apiService = APIService()
    public var upcomingMovies: [Movie] = []
    public var nowPlayingMovies: [Movie] = []
    private var currentPage = 1
    private var isFetchingMovies = false
    
    func fetchUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        apiService.fetchUpcomingMovies(page: 1) { result in
            completion(result)
        }
    }
    func fetchNowPlayingMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        apiService.fetchNowPlayingMovies(page: page, completion: completion) // Burada doğru parametreleri geçiriyoruz
    }

}

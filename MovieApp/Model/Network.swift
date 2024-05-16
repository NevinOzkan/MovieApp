//
//  Network.swift
//  MovieApp
//
//  Created by Nevin Özkan on 13.05.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = Secrets.tmdbApiKey
    private let baseURL = "https://api.themoviedb.org/3/movie/popular?api_key=1ae0a7f53c245e3bc03196612d1e663a"
    private let nowPlayingEndpoint = "movie/now_playing"
    private let upcomingEndpoint = "movie/upcoming"
    
    private init() {}
    
    func fetchNowPlayingMovies(completion: @escaping (Result<Movies, Error>) -> Void) {
        let nowPlayingURL = baseURL + nowPlayingEndpoint
        let parameters: Parameters = ["api_key": apiKey]
        
        AF.request(nowPlayingURL, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: Movies.self) { response in
                switch response.result {
                case .success(let moviesResponse):
                    completion(.success(moviesResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchUpcomingMovies(completion: @escaping (Result<Movies, Error>) -> Void) {
        let upcomingURL = baseURL + upcomingEndpoint
        let parameters: Parameters = ["1ae0a7f53c245e3bc03196612d1e663a": apiKey]
        
        AF.request(upcomingURL, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: Movies.self) { response in
                switch response.result {
                case .success(let moviesResponse):
                    completion(.success(moviesResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}



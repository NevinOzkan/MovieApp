//
//  APIService.swift
//  MovieApp
//
//  Created by Nevin Özkan on 5.10.2024.
//

import Foundation
import Alamofire

class APIService{
    
    func fetchUpcomingMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let upcomingMoviesURL = "\(Constants.URL.upcomingUrl)?api_key=\(Constants.API.apiKey)\(Constants.Params.page)\(page)"
        
        let parameters: [String: String] = [
            "language": "en-US",
            "page": "\(page)"
        ]
        
        
        AF.request(upcomingMoviesURL, parameters: parameters)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(MovieResponse.self, from: data)
                        completion(.success(response.results))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Network error: \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    func fetchNowPlayingMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        let nowPlayingMoviesURL = "\(Constants.URL.nowPlayingUrl)?api_key=\(Constants.API.apiKey)\(Constants.Params.page)\(page)"
        let parameters: [String: String] = [
            "language": "en-US",
            "page": "\(page)"
        ]
        
        // Alamofire ile istek yap
        AF.request(nowPlayingMoviesURL)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(MovieResponse.self, from: data)
                        completion(.success(response.results))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Network error: \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        let movieDetailsURL = "\(Constants.URL.movieDetailUrl)\(movieID)?api_key=\(Constants.API.apiKey)"
        
        AF.request(movieDetailsURL)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let movie = try decoder.decode(Movie.self, from: data)
                        completion(.success(movie))
                    } catch {
                        print("Decoding error: \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Network error: \(error)")
                    if let data = response.data, let errorResponse = String(data: data, encoding: .utf8) {
                        print("Error response: \(errorResponse)")
                    }
                    completion(.failure(error))
                }
            }
    }
    
}

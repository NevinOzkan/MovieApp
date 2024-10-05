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
}
